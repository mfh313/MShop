//
//  MMServiceCenter.h
//  YJCustom
//
//  Created by EEKA on 16/9/22.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMServiceCenter : NSObject
{
    NSMutableDictionary *m_dicService;
    NSRecursiveLock *m_lock;
}

+ (id)defaultCenter;
- (void)callClearData;
- (void)callEnterBackground;
- (void)callEnterForeground;
- (void)callReloadData;
- (void)callServiceMemoryWarning;
- (void)callTerminate;

- (id)getService:(Class)aclass;
- (id)init;
- (void)removeService:(Class)aclass;

@end
