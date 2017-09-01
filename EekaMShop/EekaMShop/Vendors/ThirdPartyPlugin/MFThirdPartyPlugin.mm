//
//  MFThirdPartyPlugin.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MFThirdPartyPlugin.h"
#import <Bugly/Bugly.h>
#import <JSPatchPlatform/JSPatch.h>
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "WWKApi.h"
#import "MShopLoginService.h"
#import "MMServerPushService.h"

#import <WCDB/WCDB.h>
#import <WCDB/WCTStatistics.h>

#define JSPatch_APP_KEY @"a3ea2110954730fe"
#define BUGLY_APP_ID @"11db5a0376"
#define JPUSH_APP_KEY @"97144cda4d1a6c13f653b8f1"

static NSInteger seq = 0;

@interface MFThirdPartyPlugin () <JPUSHRegisterDelegate,WWKApiDelegate>
{
    
}

@end

@implementation MFThirdPartyPlugin

-(void)registerPluginsApplication:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registerBugly];
    [self registerJSPatchHotFix];
    [self registerJPUSHServiceApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self registerJPUSHNotificationCenter];
    [self registerWWK];
}

-(void)registerBugly
{
    BuglyConfig *config = [BuglyConfig new];
    config.blockMonitorEnable = YES;
    config.unexpectedTerminatingDetectionEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
    
#ifdef DEBUG
    config.channel = @"调试渠道";
#endif
    
    [Bugly startWithAppId:BUGLY_APP_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    [BuglyLog initLogger:BuglyLogLevelWarn consolePrint:YES];
}


-(void)registerJSPatchHotFix
{
    [JSPatch startWithAppKey:JSPatch_APP_KEY];
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3012nn3sDTLl7sb5ruqC\nDE+jCnPDadJ07wco0svJi7ZImCfv27J8PEChPZsU7oCv/qIhHNWUjbnqY9khAgv7\ny5MeWS7oSSnhoBWtMxXoiCzcpzJ5x/RlM0ZoHSQ71X1i3ULx9Xmm6eaVT16I5jYV\npAm95hftQuTg9gSSgY2L9RyQOnQMMk5qyD1KUqiZ4q6sGwakyU0khKdZWs0AuLcu\n84RGMDoS5X5iD4ZjdbVTNIqw5/yBpL/KHNxyRfVGi0UjMdFxvZ2slKgg0JxKtRui\n0JKEKi5R8T3kpFzJQtVYbmeg5K0g0dCwWmWXRrn20j4FnJ3t9eBXk9lnyb5tpjCR\nZQIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch sync];
}

-(void)registerJPUSHServiceApplication:(UIApplication *)application
         didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPUSH_APP_KEY
                          channel:@"Publish channel"
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0)
        {
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else
        {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

-(void)registerJPUSHDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    [self handlePushMessage:alert];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

- (NSString *)logDic:(NSDictionary *)dic
{
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];

    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}

-(void)registerWWK
{
    [WWKApi registerApp:@"wwauthde623adaa711cfb6000006" corpId:@"wxde623adaa711cfb6" agentId:@"1000006"];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    /*! @brief 处理外部调用URL的时候需要将URL传给SDK进行相关处理
     * @param url 外部调用传入的url
     * @param delegate 当前类需要实现WWKApiDelegate对应的方法
     */
    return [WWKApi handleOpenURL:url delegate:self];
}

- (void)onResp:(WWKBaseResp *)resp {
    /*! @brief 所有通过sendReq发送的SDK请求的结果都在这个函数内部进行异步回调
     * @ param resp SDK处理请求后的返回结果 需要判断具体是哪项业务的回调
     */
    NSMutableString *extra = [NSMutableString string];
    
    /* 选择联系人的回调 */
    if ([resp isKindOfClass:[WWKPickContactResp class]]) {
        WWKPickContactResp *r = (WWKPickContactResp *)resp;
        for (int i = 0; i < MIN(r.contacts.count, 5); ++i) {
            if (extra.length) [extra appendString:@"\n"];
            [extra appendFormat:@"%@<%@>", [r.contacts[i] name], [r.contacts[i] email]];
        }
        if (r.contacts.count > 5) {
            [extra appendString:@"\n…"];
        }
    }
    
    /* SSO的回调 */
    if ([resp isKindOfClass:[WWKSSOResp class]]) {
        WWKSSOResp *r = (WWKSSOResp *)resp;
        [extra appendFormat:@"%@ for %@", r.code, r.state];
        
        MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
        [loginService loginWithWWKSSOResp:r];
    }
    
    if (extra.length) [extra insertString:@"\n\n" atIndex:0];
}

-(void)registerJPUSHNotificationCenter
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
}

- (void)networkDidSetup:(NSNotification *)notification {

    NSLog(@"已连接");

}

- (void)networkDidClose:(NSNotification *)notification {

    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);

    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {

    NSLog(@"已登录");
    
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID =%@",[JPUSHService registrationID]);
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    
    NSLog(@"title=%@,content=%@,[self logDic:extra]=%@", title,content,[self logDic:extra]);
    
    [self handlePushMessage:content];
}

-(void)handlePushMessage:(NSString *)content
{
    BOOL needShowPushAlert = [MMServerPushService needShowPushAlert:content];
    if (needShowPushAlert)
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showWarning:@"提示" subTitle:content closeButtonTitle:@"确定" duration:0];
    }
}

- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [JSPatch sync];
}

-(void)setJPushTAG
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
    
    NSString *pushAlias = currentLoginUserInfo.userId;
    
    if ([currentLoginUserInfo isShopKeeper])
    {
        pushAlias = [NSString stringWithFormat:@"%@%@",[loginService currentLoginUserDepartment],@"店长"];
    }
    
    MFThirdPartyPlugin *thirdPartyPlugin = [[MMServiceCenter defaultCenter] getService:[MFThirdPartyPlugin class]];
    [thirdPartyPlugin setPushAlias:pushAlias];
}

-(void)setPushAlias:(NSString *)pushAlias
{
    [JPUSHService setAlias:pushAlias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"iResCode=%@,iAlias=%@,seq=%@",@(iResCode),iAlias,@(seq));
        
    } seq:[self seq]];
}

-(void)deletePushAlias
{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"iResCode=%@,iAlias=%@,seq=%@",@(iResCode),iAlias,@(seq));
        
    } seq:[self seq]];
}

- (NSInteger)seq {
    return ++ seq;
}

+(void)testCrash
{
    NSArray * array = @[@"1", @"2"];
    
    NSLog(@"print %@", [array objectAtIndex:2]);
}

-(void)setWCDBMonitor
{
    //Error Monitor
    [WCTStatistics SetGlobalErrorReport:^(WCTError *error) {
        NSLog(@"[WCDB]%@", error);
    }];
    
    [WCTStatistics SetGlobalPerformanceTrace:^(WCTTag tag, NSDictionary<NSString*, NSNumber*>* sqls, NSInteger cost) {
        NSLog(@"Tag: %d", tag);
        [sqls enumerateKeysAndObjectsUsingBlock:^(NSString *sql, NSNumber *count, BOOL *) {
            NSLog(@"SQL: %@ Count: %d", sql, count.intValue);
        }];
        NSLog(@"Total cost %ld nanoseconds", (long)cost);
    }];
}

@end
