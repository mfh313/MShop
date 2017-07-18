//
//  MMServiceCenter.m
//  YJCustom
//
//  Created by EEKA on 16/9/22.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMServiceCenter.h"

@implementation MMServiceCenter

+ (id)defaultCenter
{
    static MMServiceCenter *_sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCenter = [[self alloc] init];
    });
    
    return _sharedCenter;
}

-(id)init
{
    self = [super init];
    if (self) {
        m_dicService = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)getService:(Class)aclass
{
    NSString *keyClass = NSStringFromClass(aclass);
    id object = m_dicService[keyClass];
    if (!object) {
        
        m_dicService[keyClass] = [aclass new];
        
        object = m_dicService[keyClass];
    }
    
    return object;
}

- (void)removeService:(Class)aclass
{
    NSString *keyClass = NSStringFromClass(aclass);
    [m_dicService removeObjectForKey:keyClass];
}



@end
