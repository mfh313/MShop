//
//  NSMutableArray+SafeInsert.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "NSMutableArray+SafeInsert.h"

@implementation NSMutableArray (SafeInsert)

- (void)safeAddObject:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

@end
