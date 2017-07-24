//
//  MShopGetMemberListApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopGetMemberListApi.h"

@implementation MShopGetMemberListApi

-(NSString *)requestUrl
{
    return [MShopApiManger getIndividualListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


@end
