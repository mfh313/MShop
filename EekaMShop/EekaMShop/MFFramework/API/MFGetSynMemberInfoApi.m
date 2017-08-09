//
//  MFGetSynMemberInfoApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/9.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFGetSynMemberInfoApi.h"

@implementation MFGetSynMemberInfoApi

-(NSString *)requestUrl
{
    return [MShopApiManger getSynMemberInfoURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(BOOL)useToken
{
    return NO;
}

@end
