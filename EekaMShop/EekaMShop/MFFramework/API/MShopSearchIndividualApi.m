//
//  MShopSearchIndividualApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopSearchIndividualApi.h"

@implementation MShopSearchIndividualApi

-(NSString *)requestUrl
{
    return [MShopApiManger searchIndividualURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    return @{
             @"searchKey":self.searchKey
             };
    
}

@end
