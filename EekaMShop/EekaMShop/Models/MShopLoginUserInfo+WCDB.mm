//
//  MShopLoginUserInfo+WCDB.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginUserInfo+WCDB.h"

@implementation MShopLoginUserInfo (WCDB)

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
WCDB_UNIQUE(MShopLoginUserInfo, userId)

@end
