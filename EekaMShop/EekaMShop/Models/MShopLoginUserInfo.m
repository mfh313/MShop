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


@end
