//
//  NSMutableArray+SafeInsert.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeInsert)

- (id)firstObject;
- (void)removeFirstObject;
- (void)safeAddObject:(id)object;
- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

@end
