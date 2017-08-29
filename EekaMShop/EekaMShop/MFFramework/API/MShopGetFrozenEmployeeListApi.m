//
//  MShopGetFrozenEmployeeListApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetFrozenEmployeeListApi.h"

@implementation MShopGetFrozenEmployeeListApi

-(NSString *)requestUrl
{
    return [MShopApiManger getFrozenEmployeeListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
