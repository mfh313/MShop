//
//  MShopMainFrameViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMainFrameViewController.h"
#import "MShopMainFrameLogicController.h"
#import "MShopMemberListViewController.h"

@interface MShopMainFrameViewController ()
{
    MShopMainFrameLogicController *m_logic;
}

@end

@implementation MShopMainFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
}

- (IBAction)onClickMemberManager:(id)sender
{
    MShopMemberListViewController *employeeListVC = [MShopMemberListViewController new];
    employeeListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:employeeListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
