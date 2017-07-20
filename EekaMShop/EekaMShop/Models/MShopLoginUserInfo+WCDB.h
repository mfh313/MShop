//
//  MShopLoginUserInfo+WCDB.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginUserInfo.h"
#import <WCDB/WCDB.h>

@interface MShopLoginUserInfo (WCDB)

WCDB_PROPERTY(token)
WCDB_PROPERTY(avatar)
WCDB_PROPERTY(department)
WCDB_PROPERTY(email)
WCDB_PROPERTY(englishName)
WCDB_PROPERTY(extattr)
WCDB_PROPERTY(gender)
WCDB_PROPERTY(isLeader)
WCDB_PROPERTY(mobile)
WCDB_PROPERTY(name)
WCDB_PROPERTY(position)
WCDB_PROPERTY(status)
WCDB_PROPERTY(telephone)
WCDB_PROPERTY(userId)
WCDB_PROPERTY(timestamp)

@end
