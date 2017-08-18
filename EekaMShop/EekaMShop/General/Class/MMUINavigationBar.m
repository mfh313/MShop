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
        _barBackShadowView.frame = CGRectMake(0, -20, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + 20);
        _barBackShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _barBackShadowView.backgroundColor = [UIColor hx_colorWithHexString:@"000000"];
        [self addSubview:_barBackShadowView];
        
        //去掉底部黑线
        [self setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        
        //自定义黑线
        _navBarLine = [UIView new];
        _navBarLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - MFOnePixHeight, CGRectGetWidth(self.bounds), MFOnePixHeight);
        _navBarLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _navBarLine.backgroundColor = [UIColor hx_colorWithHexString:@"d3d4d6"];
        [self addSubview:_navBarLine];
        
        [self sendSubviewToBack:_barBackShadowView];
        [self sendSubviewToBack:_navBarLine];
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _barBackShadowView.frame = CGRectMake(0, -20, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + 20);
    [self sendSubviewToBack:_barBackShadowView];
}


@end
