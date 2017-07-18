//
//  MMService.h
//  YJCustom
//
//  Created by EEKA on 16/9/22.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMService : NSObject
{
    BOOL m_isServiceRemoved;
    BOOL m_isServicePersistent;
}

@property (nonatomic,assign) BOOL m_isServiceRemoved;
@property (nonatomic,assign) BOOL m_isServicePersistent;

@end
