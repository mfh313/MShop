//
//  MFThirdPartyPlugin.h
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFThirdPartyPlugin : NSObject

+(void)testCrash;
    
-(void)registerPluginsApplication:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)applicationDidBecomeActive:(UIApplication *)application;

-(void)registerJPUSHDeviceToken:(NSData *)deviceToken;

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

-(void)setPushAlias:(NSString *)pushAlias;

-(void)deletePushAlias;

-(void)setJPushTAG;

@end
