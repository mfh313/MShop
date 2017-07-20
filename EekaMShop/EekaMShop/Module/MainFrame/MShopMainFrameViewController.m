//
//  MShopMainFrameViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMainFrameViewController.h"
#import "MShopMainFrameLogicController.h"
#import "MShopEmployeeListViewController.h"

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MShop_MainFrame" bundle:nil];
    MShopEmployeeListViewController *employeeListVC = [storyboard instantiateViewControllerWithIdentifier:@"MShopEmployeeListViewController"];
    employeeListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:employeeListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
