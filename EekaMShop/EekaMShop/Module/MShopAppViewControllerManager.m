//
//  MShopAppViewControllerManager.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppViewControllerManager.h"
#import "MShopLoginViewController.h"
#import "MShopMainFrameViewController.h"
#import "MShopMeViewController.h"
#import "MMTabBarController.h"

@implementation MShopAppViewControllerManager

+ (id)getAppViewControllerManager
{
    static MShopAppViewControllerManager *_sharedAppViewControllerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAppViewControllerManager = [[self alloc] init];
    });
    
    return _sharedAppViewControllerManager;
}

-(id)initWithWindow:(UIWindow *)window
{
    self = [[self class] getAppViewControllerManager];
    if (self) {
        m_window = window;
    }
    return self;
}

-(void)jumpToLoginViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MShopLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"MShopLoginViewController"];
    m_window.rootViewController  = loginVC;
}

-(void)createMainTabViewController
{
    MShopMainFrameViewController *mainFrameVC = [[MShopMainFrameViewController alloc] init];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainFrameVC];
    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"主页"
                                                              image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = homeTabItem;
    
    MShopMeViewController *meVC = [MShopMeViewController new];
    MMNavigationController *meRootNav = [[MMNavigationController alloc] initWithRootViewController:meVC];
    UITabBarItem *setTabItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                             image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meRootNav.tabBarItem = setTabItem;
    
    m_tabbarController = [self getTabBarController];
    m_tabbarController.viewControllers = @[rootNav,meRootNav];
    m_tabbarController.tabBar.barTintColor = [UIColor whiteColor];
    
    m_window.rootViewController = m_tabbarController;
}

+ (id)getTabBarController
{
    return [[self getAppViewControllerManager] getTabBarController];
}

-(void)userLogOut
{
    m_tabbarController = nil;
}

- (id)getTabBarController
{
    if (!m_tabbarController) {
        m_tabbarController = [[MMTabBarController alloc] init];
    }
    
    return m_tabbarController;
}

@end
