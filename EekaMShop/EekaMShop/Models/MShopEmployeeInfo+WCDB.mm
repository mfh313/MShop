//
//  MShopEmployeeInfo+WCDB.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopEmployeeInfo+WCDB.h"

@implementation MShopEmployeeInfo (WCDB)

WCDB_IMPLEMENTATION(MShopEmployeeInfo)

WCDB_SYNTHESIZE(MShopEmployeeInfo, userId)
WCDB_SYNTHESIZE(MShopEmployeeInfo, avatar)
WCDB_SYNTHESIZE(MShopEmployeeInfo, department)
WCDB_SYNTHESIZE(MShopEmployeeInfo, email)
WCDB_SYNTHESIZE(MShopEmployeeInfo, englishName)
WCDB_SYNTHESIZE(MShopEmployeeInfo, extattr)
WCDB_SYNTHESIZE(MShopEmployeeInfo, gender)
WCDB_SYNTHESIZE(MShopEmployeeInfo, isLeader)
WCDB_SYNTHESIZE(MShopEmployeeInfo, mobile)
WCDB_SYNTHESIZE(MShopEmployeeInfo, name)
WCDB_SYNTHESIZE(MShopEmployeeInfo, position)
WCDB_SYNTHESIZE(MShopEmployeeInfo, status)
WCDB_SYNTHESIZE(MShopEmployeeInfo, telephone)
WCDB_SYNTHESIZE_DEFAULT(MShopEmployeeInfo, timestamp, WCTDefaultTypeCurrentTimestamp)


WCDB_PRIMARY(MShopEmployeeInfo, userId)

@end
