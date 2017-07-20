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
    NSDictionary *dict = request.responseJSONObject;
    NSNumber *number = dict[@"errcode"];
    if (number.intValue == 4001)
    {
        return YES;
    }
    
    return NO;
}

-(void)handleTokenExpire
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    [loginService logout];
}

@end
