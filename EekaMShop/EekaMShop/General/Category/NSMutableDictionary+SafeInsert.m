//
//  NSMutableDictionary+SafeInsert.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "NSMutableDictionary+SafeInsert.h"

@implementation NSMutableDictionary (SafeInsert)

- (void)safeRemoveObjectForKey:(NSString *)key
{
    if (key) {
        [self removeObjectForKey:key];
    }
}

- (void)safeSetObject:(id)object forKey:(NSString *)key
{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}

@end
