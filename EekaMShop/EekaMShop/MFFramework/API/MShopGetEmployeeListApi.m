//
//  MShopGetEmployeeListApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetEmployeeListApi.h"

@implementation MShopGetEmployeeListApi

-(NSString *)requestUrl
{
    return [MShopApiManger getEmployeeListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    return @{
             @"department":self.deptId
             };
}

@end
