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

#define JSPatch_APP_KEY @"a3ea2110954730fe"
#define BuglyAppID @"11db5a0376"

@implementation MFThirdPartyPlugin

-(void)registerPlugins
{
    [self registerBugly];
    
    [self registerJSPatchHotFix];
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
    [Bugly startWithAppId:BuglyAppID config:config];
    
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [JSPatch sync];
}

@end
