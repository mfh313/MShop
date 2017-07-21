//
//  NSCache+SafeInsert.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCache (SafeInsert)

- (void)safeRemoveObjectForKey:(id)arg1;
- (void)safeSetObject:(id)arg1 forKey:(id)arg2;

@end
