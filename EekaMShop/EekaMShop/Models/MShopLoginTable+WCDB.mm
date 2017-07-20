//
//  MShopLoginTable+WCDB.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginTable+WCDB.h"

@implementation MShopLoginTable (WCDB)

WCDB_IMPLEMENTATION(MShopLoginTable)
WCDB_SYNTHESIZE(MShopLoginTable, token)
WCDB_SYNTHESIZE(MShopLoginTable, userId)
WCDB_SYNTHESIZE(MShopLoginTable, createTime)
WCDB_SYNTHESIZE(MShopLoginTable, modifiedTime)

@end
