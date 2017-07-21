//
//  MShopLoginApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginApi.h"

@implementation MShopLoginApi

-(NSString *)requestUrl
{
    return [MShopApiManger loginURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"code":self.code
             };
}

@end
