//
//  NSMutableDictionary+SafeInsert.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SafeInsert)

- (void)safeRemoveObjectForKey:(NSString *)key;
- (void)safeSetObject:(id)object forKey:(NSString *)key;

@end
