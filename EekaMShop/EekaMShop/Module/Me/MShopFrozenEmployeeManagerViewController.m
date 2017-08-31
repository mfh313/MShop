//
//  MShopFrozenEmployeeManagerViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopFrozenEmployeeManagerViewController.h"

@interface MShopFrozenEmployeeManagerViewController ()

@end

@implementation MShopFrozenEmployeeManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"员工冻结管理";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
