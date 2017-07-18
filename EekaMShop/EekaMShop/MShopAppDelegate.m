//
//  MShopAppDelegate.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppDelegate.h"
#import "WWKApi.h"

@interface MShopAppDelegate () <WWKApiDelegate>

@end

@implementation MShopAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*! @brief 不走管理端的注册方式
     *
     * 或许不久的将来我们会开放支持仅仅通过第三方App的schema作为AppId来进行注册，继而调用SDK对应的接口进行工作
     * 这个接口虽然现在开放了，但暂时还没有开放权限，敬请期待...
     * @param registerApp 第三方App的Schema
     */
    // [WWKApi registerApp:@"wwauth797275b8b439f4b5000002"];
    
    
    /*! @brief 调用这个方法前需要先到管理端进行注册 走管理端的注册方式
     *
     * 在管理端通过注册(可能需要等待审批)，获得schema+corpid+agentid
     * @param registerApp 第三方App的Schema
     * @param registerApp 第三方App所属企业的ID
     * @param registerApp 第三方App在企业内部的ID
     */
    [WWKApi registerApp:@"wwauthde623adaa711cfb6000006" corpId:@"wxde623adaa711cfb6" agentId:@"1000006"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self handleOpenURL:url sourceApplication:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url sourceApplication:sourceApplication];
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
     * @param resp SDK处理请求后的返回结果 需要判断具体是哪项业务的回调
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
    }
    
    if (extra.length) [extra insertString:@"\n\n" atIndex:0];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"返回结果" message:[NSString stringWithFormat:@"错误码：%d\n错误信息：%@%@", resp.errCode, resp.errStr, extra] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
