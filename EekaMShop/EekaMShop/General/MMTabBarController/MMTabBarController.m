//
//  MMTabBarController.m
//  YJCustom
//
//  Created by EEKA on 16/9/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMTabBarController.h"

@interface MMTabBarController ()

@end

@implementation MMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)setTabBarBadgeValue:(NSInteger)value forIndex:(NSInteger)index
{
    UIViewController *indexVC = self.viewControllers[index];
    
    if (value > 0) {
        indexVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",value];
    }
    else
    {
        indexVC.tabBarItem.badgeValue = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
