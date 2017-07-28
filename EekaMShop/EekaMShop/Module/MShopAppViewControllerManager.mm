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
#import "MShopMemberListViewController.h"


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
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MShop_MainFrame" bundle:nil];
//    MShopMainFrameViewController *mainFrameVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MShopMainFrameViewController"];
//    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainFrameVC];
//    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"主页"
//                                                              image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                      selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    rootNav.tabBarItem = homeTabItem;
    MShopMemberListViewController *employeeListVC = [MShopMemberListViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:employeeListVC];
    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"会员列表"
                                                              image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = homeTabItem;
    
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:@"Mshop_Me" bundle:nil];
    MShopMeViewController *meVC = [meStoryboard instantiateViewControllerWithIdentifier:@"MShopMeViewController"];
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

+ (MMTabBarController *)getTabBarController
{
    return [[self getAppViewControllerManager] getTabBarController];
}

-(void)userLogOut
{
    m_tabbarController = nil;
}

- (MMTabBarController *)getTabBarController
{
    if (!m_tabbarController) {
        m_tabbarController = [[MMTabBarController alloc] init];
    }
    
    return m_tabbarController;
}

@end
