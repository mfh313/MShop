//
//  UIViewController+UINavigationItem.m
//  BloomBeauty
//
//  Created by Administrator on 15/12/17.
//  Copyright © 2015年 EEKA. All rights reserved.
//

#import "UIViewController+UINavigationItem.h"

@implementation UIViewController (UINavigationItem)

-(void)setLeftNaviButtonWithAction:(SEL)anAction
{
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 47, 30);
    [leftBarButton setImage:MFImage(@"back") forState:UIControlStateNormal];

    [leftBarButton setBackgroundColor:[UIColor clearColor]];
    if ([self respondsToSelector:anAction]) {
        [leftBarButton addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    [self setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftBarButton]];
}

-(void)setLeftNaviButtonWithTitle:(NSString *)title action:(SEL)anAction
{
    UIFont *titleFont = [UIFont systemFontOfSize:16.0];
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.titleLabel.font = titleFont;
    
    leftBarButton.frame = CGRectMake(0, 0, 70, 30);
    [leftBarButton setTitle:title forState:UIControlStateNormal];
    [leftBarButton setTitleColor:MFCustomDefaultColor forState:UIControlStateNormal];
    [leftBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [leftBarButton setBackgroundColor:[UIColor clearColor]];
    if ([self respondsToSelector:anAction]) {
        [leftBarButton addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftBarButton]];
}

-(void)setRightNaviButtonWithTitle:(NSString *)title action:(SEL)anAction
{
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    rightBarButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    rightBarButton.frame = CGRectMake(0, 0, 60, 33);
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    [rightBarButton setTitleColor:MFCustomDefaultColor forState:UIControlStateNormal];
    [rightBarButton setBackgroundColor:[UIColor clearColor]];
    if ([self respondsToSelector:anAction]) {
        [rightBarButton addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightBarButton]];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        
        if (_leftBarButtonItem)
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        
        if (_rightBarButtonItem)
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

@end
