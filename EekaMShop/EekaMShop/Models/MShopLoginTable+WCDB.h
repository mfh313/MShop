//
//  MShopLoginTable+WCDB.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginTable.h"
#import <WCDB/WCDB.h>

@interface MShopLoginTable (WCDB) <WCTTableCoding>

WCDB_PROPERTY(token)
WCDB_PROPERTY(userId)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)

@end
