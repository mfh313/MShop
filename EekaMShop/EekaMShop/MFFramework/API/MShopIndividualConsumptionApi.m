//
//  MShopIndividualConsumptionApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopIndividualConsumptionApi.h"

@implementation MShopIndividualConsumptionApi

-(NSString *)requestUrl
{
    return [MShopApiManger individualConsumptionURL];
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
