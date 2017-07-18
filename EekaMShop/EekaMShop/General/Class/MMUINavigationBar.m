//
//  MMUINavigationBar.m
//  BloomBeauty
//
//  Created by EEKA on 16/8/9.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUINavigationBar.h"

@implementation MMUINavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _barBackShadowView = [UIView new];
        _barBackShadowView.frame = CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20);
        _barBackShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _barBackShadowView.backgroundColor = [UIColor hx_colorWithHexString:@"0080C0"];
        [self addSubview:_barBackShadowView];
        
        [self bringSubviewToFront:_barBackShadowView];
        
        _navBarLine = [UIView new];
        _navBarLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - MFOnePixHeight, CGRectGetWidth(self.bounds), MFOnePixHeight);
        _navBarLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _navBarLine.backgroundColor = [UIColor clearColor];
        [self addSubview:_navBarLine];
        
        self.translucent = YES;
        
    }
    
    return self;
}



@end
