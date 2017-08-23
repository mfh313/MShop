//
//  MMServerPushService.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

@interface MMServerPushService : MMService

+(BOOL)needShowPushAlert:(NSString *)content;

@end
