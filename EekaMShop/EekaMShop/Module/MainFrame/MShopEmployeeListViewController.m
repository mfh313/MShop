//
//  MShopEmployeeListViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopEmployeeListViewController.h"
#import "MFTableViewInfo.h"
#import "MShopGetEmployeeListApi.h"

@interface MShopEmployeeListViewController ()
{
    
}

@end

@implementation MShopEmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员列表";
    
    [self getEmployeeList];
}

-(void)getEmployeeList
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetEmployeeListApi *getEmployeeListApi = [MShopGetEmployeeListApi new];
    getEmployeeListApi.deptId = @"13041";
    getEmployeeListApi.animatingText = @"正在获取会员列表...";
    getEmployeeListApi.animatingView = MFAppWindow;
    [getEmployeeListApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!getEmployeeListApi.messageSuccess) {
            [self showTips:getEmployeeListApi.errorMessage];
            return;
        }
        
        NSLog(@"request.responseObject=%@",request.responseObject);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
