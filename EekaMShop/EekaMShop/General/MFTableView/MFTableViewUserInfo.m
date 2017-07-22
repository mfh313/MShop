//
//  MFTableViewUserInfo.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/27.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewUserInfo.h"

@implementation MFTableViewUserInfo

-(void)addUserInfoValue:(id)value forKey:(NSString *)key
{
    NSParameterAssert(key);
    
    if (!_dicInfo) {
        _dicInfo = [NSMutableDictionary dictionary];
    }
    
    if (value) {
        [_dicInfo setObject:value forKey:key];
    }
}

- (id)getUserInfoValueForKey:(NSString *)key
{
    NSParameterAssert(key);
    
    if (_dicInfo) {
        return [_dicInfo objectForKey:key];
    }
    return nil;
}

@end
