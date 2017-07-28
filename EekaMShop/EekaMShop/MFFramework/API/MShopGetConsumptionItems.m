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

-(id)requestArgumentWithToken
{
    return @{
             @"individualId":self.individualId
             };
    
}

@end
