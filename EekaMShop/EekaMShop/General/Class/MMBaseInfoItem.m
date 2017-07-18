//
//  MMBaseInfoItem.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMBaseInfoItem.h"

@implementation MMBaseInfoItem
@synthesize m_key,m_tip,m_title,m_view,m_bActive,m_bEnable;
    
- (void)becomeFirstResponder
{
    
}
    
- (id)getValue
{
    return nil;
}
    
- (void)initView:(CGRect)frame
{
    
}
    
- (id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key
{
    self = [super init];
    if (self) {
        m_title = title;
        m_tip = tip;
        m_key = key;
    }
    
    return self;
}
    
- (void)resignFirstResponder
{
    
}

- (void)setDelegate:(id)delegate
{
    m_delegate = delegate;
}

- (void)setEnable:(BOOL)enable
{
    m_bEnable = enable;
}

- (void)setSuperView:(UIView *)view
{
    m_superView = view;
}
    

@end
