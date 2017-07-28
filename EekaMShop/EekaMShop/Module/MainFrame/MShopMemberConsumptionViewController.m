//
//  MShopMemberConsumptionViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/28.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberConsumptionViewController.h"
#import "MFTableViewInfo.h"
#import "MShopIndividualInfo.h"

@interface MShopMemberConsumptionViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
}

@end

@implementation MShopMemberConsumptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消费记录";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
