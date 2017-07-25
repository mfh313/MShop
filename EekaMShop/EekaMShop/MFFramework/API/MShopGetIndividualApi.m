//
//  MShopGetIndividualApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetIndividualApi.h"

@implementation MShopGetIndividualApi

-(NSString *)requestUrl
{
    return [MShopApiManger getIndividualURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    if (self.individualId) {
        return @{
                 @"individualId ":self.individualId
                 };
    }
    
    return nil;
    
}

@end
