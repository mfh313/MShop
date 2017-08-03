//
//  MShopGetAppointmentListApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetAppointmentListApi.h"

@implementation MShopGetAppointmentListApi

-(NSString *)requestUrl
{
    return [MShopApiManger getAppointmentListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(void)setPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    _usePaging = YES;
    _pageIndex = pageIndex;
    _pageSize = pageSize;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    if (_usePaging) {
        requestArgument[@"pageIndex"] = @(_pageIndex);
        requestArgument[@"pageSize"] = @(_pageSize);
    }
    
    return requestArgument;
}

@end
