//
//  MShopLoginUserInfo.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MShopEmployeeInfo.h"

@interface MShopLoginUserInfo : MShopEmployeeInfo

@property (nonatomic,strong) NSString *token;

WCDB_PROPERTY(token)

@end
