//
//  MShopSendVerificationCodeApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/6.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopSendVerificationCodeApi.h"

@implementation MShopSendVerificationCodeApi

-(NSString *)requestUrl
{
    return [MShopApiManger sendVerificationCodeURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"phone"] = self.phone;
    
    return requestArgument;
}

-(NSString *)verificationCode
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSDictionary *dict = self.responseJSONObject;
    id string = dict[@"errmsg"];
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
    
    return string;
}

@end
