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
#import "MShopAppointmentListViewController.h"


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
    MShopMemberListViewController *employeeListVC = [MShopMemberListViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:employeeListVC];
    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"会员列表"
                                                              image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = homeTabItem;
    
    
    UIViewController *appointmentListVC = [self appointmentListVC];
    MMNavigationController *rootAppointmentNav = [[MMNavigationController alloc] initWithRootViewController:appointmentListVC];
    UITabBarItem *appointmentTabItem = [[UITabBarItem alloc] initWithTitle:@"会员预约"
                                                              image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootAppointmentNav.tabBarItem = appointmentTabItem;
    
    
    MShopMeViewController *meVC = [MShopMeViewController new];
    MMNavigationController *meRootNav = [[MMNavigationController alloc] initWithRootViewController:meVC];
    UITabBarItem *setTabItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                             image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meRootNav.tabBarItem = setTabItem;
    
    m_tabbarController = [self getTabBarController];
    m_tabbarController.viewControllers = @[rootNav,rootAppointmentNav,meRootNav];
    m_tabbarController.tabBar.barTintColor = [UIColor whiteColor];
    m_window.rootViewController = m_tabbarController;
    
    [m_tabbarController setSelectedIndex:0];
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

-(UIViewController *)appointmentListVC
{
    MShopAppointmentListViewController *appointmentListVC = [MShopAppointmentListViewController new];
    return appointmentListVC;
}

@end
