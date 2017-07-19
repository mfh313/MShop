//
//  MShopLoginUserInfo.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginUserInfo.h"

@implementation MShopLoginUserInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"token" : @"errmsg"
             };
}

WCDB_IMPLEMENTATION(MShopLoginUserInfo)

WCDB_SYNTHESIZE(MShopLoginUserInfo, userId)
WCDB_SYNTHESIZE(MShopLoginUserInfo, token)
WCDB_SYNTHESIZE(MShopLoginUserInfo, avatar)
WCDB_SYNTHESIZE(MShopLoginUserInfo, department)
WCDB_SYNTHESIZE(MShopLoginUserInfo, email)
WCDB_SYNTHESIZE(MShopLoginUserInfo, englishName)
WCDB_SYNTHESIZE(MShopLoginUserInfo, extattr)
WCDB_SYNTHESIZE(MShopLoginUserInfo, gender)
WCDB_SYNTHESIZE(MShopLoginUserInfo, isLeader)
WCDB_SYNTHESIZE(MShopLoginUserInfo, mobile)
WCDB_SYNTHESIZE(MShopLoginUserInfo, name)
WCDB_SYNTHESIZE(MShopLoginUserInfo, position)
WCDB_SYNTHESIZE(MShopLoginUserInfo, status)
WCDB_SYNTHESIZE(MShopLoginUserInfo, telephone)
WCDB_SYNTHESIZE_DEFAULT(MShopLoginUserInfo, timestamp, WCTDefaultTypeCurrentTimestamp)


WCDB_PRIMARY(MShopLoginUserInfo, userId)


@end
