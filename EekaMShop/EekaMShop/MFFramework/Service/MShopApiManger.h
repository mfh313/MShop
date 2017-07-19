//
//  MShopApiManger.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

@interface MShopApiManger : MMService

+(NSString *)loginURL;

+(NSString *)getEmployeeListURL;

@end
