//
//  MMTabBarController.h
//  YJCustom
//
//  Created by EEKA on 16/9/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMTabBarControllerDelegate <NSObject>

@optional

@end

@interface MMTabBarController : UITabBarController
{
    NSUInteger _viewControllersCount;
}

- (void)setTabBarBadgeValue:(NSInteger)value forIndex:(NSInteger)index;

- (void)hideTabBar;

- (void)showTabBar;

@end
