//
//  MShopAppViewControllerManager.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTabBarController.h"

@interface MShopAppViewControllerManager : NSObject
{
    UIWindow *m_window;
    MMTabBarController *m_tabbarController;
}

+(id)getAppViewControllerManager;
+(MMTabBarController *)getTabBarController;
-(id)initWithWindow:(UIWindow *)window;
-(void)userLogOut;
-(void)jumpToLoginViewController;
-(void)createMainTabViewController;

@end
