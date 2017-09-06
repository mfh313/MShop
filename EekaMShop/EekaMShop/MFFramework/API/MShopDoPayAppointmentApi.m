//
//  MShopDoPayAppointmentApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/6.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopDoPayAppointmentApi.h"

@implementation MShopDoPayAppointmentApi

-(NSString *)requestUrl
{
    return [MShopApiManger checkIndividualPointURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"individualId"] = self.individualId;
    requestArgument[@"phone"] = self.phone;
    requestArgument[@"type"] = self.type;
    
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
