//
//  NSMutableSet+SafeInsert.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (SafeInsert)

- (void)safeAddObject:(id)arg1;
- (void)safeRemoveObject:(id)arg1;

@end
