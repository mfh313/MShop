//
//  MShopEmployeeListViewController.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"

@class MShopEmployeeInfo;
@protocol MShopEmployeeListViewControllerDelegate <NSObject>

@optional
-(void)onDidSelectEmployee:(MShopEmployeeInfo *)employeeInfo;

@end

@interface MShopEmployeeListViewController : MMViewController

@property (nonatomic,weak) id<MShopEmployeeListViewControllerDelegate> m_delegate;

@end
