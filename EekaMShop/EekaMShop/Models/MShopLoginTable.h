//
//  MShopLoginTable.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface MShopLoginTable : NSObject <WCTTableCoding>

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSDate *createTime;
@property (nonatomic,strong) NSDate *modifiedTime;

WCDB_PROPERTY(token)
WCDB_PROPERTY(userId)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)



@end
