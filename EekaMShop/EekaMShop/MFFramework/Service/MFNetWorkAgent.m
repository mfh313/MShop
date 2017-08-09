//
//  MFNetWorkAgent.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetWorkAgent.h"
#import "MFNetworkRequest.h"
#import "MShopLoginService.h"

@implementation MFNetWorkAgent

-(BOOL)tokenExpire:(MFNetworkRequest *)request
{
    if ([request.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = request.responseJSONObject;
        
        id number = dict[@"errcode"];
        if ([number isKindOfClass:[NSNumber class]]) {
            
            if (((NSNumber *)number).intValue == 4001)
            {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)handleTokenExpire
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    [loginService logout];
}

@end
