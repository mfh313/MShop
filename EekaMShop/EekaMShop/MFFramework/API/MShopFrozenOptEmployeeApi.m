//
//  MShopFrozenOptEmployeeApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopFrozenOptEmployeeApi.h"

NSString *const MShopFrozenStatusOpen = @"1";
NSString *const MShopFrozenStatusClose = @"0";

@implementation MShopFrozenOptEmployeeApi

-(NSString *)requestUrl
{
    return [MShopApiManger frozenOptEmployeeURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"employeeId"] = self.employeeId;
    requestArgument[@"employeeName"] = self.employeeName;
    requestArgument[@"status"] = self.status;
    
    return requestArgument;
}

@end
