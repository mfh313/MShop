//
//  MShopGetConsumptionItems.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/28.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetConsumptionItems.h"

@implementation MShopGetConsumptionItems

-(NSString *)requestUrl
{
    return [MShopApiManger getConsumptionItemsURL];
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
    requestArgument[@"individualId"] = self.individualId;
    
    if (_usePaging) {
        requestArgument[@"pageIndex"] = @(_pageIndex);
        requestArgument[@"pageSize"] = @(_pageSize);
    }
    
    return requestArgument;
}

@end
