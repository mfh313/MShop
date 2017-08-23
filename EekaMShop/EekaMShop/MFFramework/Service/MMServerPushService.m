//
//  MMServerPushService.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMServerPushService.h"

/*
 http://mp.eekamclub.com/ms/employeeApi/pushMessage.json?message=XXXXX&alias=xxx
 */

@implementation MMServerPushService

+(BOOL)needShowPushAlert:(NSString *)content
{
    NSLog(@"needShowPushAlert=%@",content);
    
    if ([content isEqualToString:@"versionUpdate"])
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        
        [alert addButton:@"更新" actionBlock:^{
            
            NSURL *url = [NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://www.eeka.info/EekaMShop/eekamshop.plist"];
            [[UIApplication sharedApplication] openURL:url];
            
        }];
        [alert showSuccess:@"提示" subTitle:@"有新版本更新" closeButtonTitle:nil duration:0];
        return NO;
    }
    
    return NO;
}

@end
