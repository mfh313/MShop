//
//  MShopUserIdLoginApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopUserIdLoginApi.h"

@implementation MShopUserIdLoginApi

-(NSString *)requestUrl
{
    return [MShopApiManger userLoginURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userId":self.userId
             };
}

@end
