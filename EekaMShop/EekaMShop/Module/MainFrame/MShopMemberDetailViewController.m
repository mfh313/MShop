//
//  MShopMemberDetailViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberDetailViewController.h"
#import "MFTableViewInfo.h"
#import "MShopIndividualInfo.h"
#import "MShopEmployeeInfo.h"
#import "MShopEmployeeListViewController.h"
#import "MShopIndividualModifyApi.h"
#import "MShopLoginService.h"
#import "MShopMemberProfileCellView.h"

@interface MShopMemberDetailViewController ()<MShopEmployeeListViewControllerDelegate>
{
    MFTableViewInfo *m_tableViewInfo;
}

@end

@implementation MShopMemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员资料";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    if ([self hasSelectMaintainEmployeePower]) {
        [self setRightNavView];
    }
    
    CGRect tableFrame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    [self addMemberInfoView];
}

-(BOOL)hasSelectMaintainEmployeePower
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    return [loginService hasSelectMaintainEmployeePower];
}

-(void)setRightNavView
{
    [self setRightNaviButtonWithTitle:@"分配" action:@selector(selectMaintainEmployee)];
}

-(void)selectMaintainEmployee
{
    MShopEmployeeListViewController *employeeListVC = [MShopEmployeeListViewController new];
    employeeListVC.m_delegate = self;
    employeeListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:employeeListVC animated:YES];
}

#pragma mark - MShopEmployeeListViewControllerDelegate
-(void)onDidSelectEmployee:(MShopEmployeeInfo *)employeeInfo
{
    self.individual.maintainEmployeeId = employeeInfo.userId;
    self.individual.maintainEmployeeName = employeeInfo.name;
    
    __weak typeof(self) weakSelf = self;
    MShopIndividualModifyApi *individualModifyApi = [MShopIndividualModifyApi new];
    individualModifyApi.individualInfo = self.individual;
    individualModifyApi.animatingText = @"正在分配...";
    individualModifyApi.animatingView = MFAppWindow;
    [individualModifyApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!individualModifyApi.messageSuccess) {
            [self showTips:individualModifyApi.errorMessage];
            return;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showTips:@"分配成功"];
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)addMemberInfoView
{
    [self makeProfileCell];
    [self makeInfoCells];
}

-(void)makeProfileCell
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeProfileCellView:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:108.0f
                                                               userInfo:nil];
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)makeProfileCellView:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    MShopMemberProfileCellView *cellView = [MShopMemberProfileCellView nibView];
    cell.m_subContentView = cellView;
    cellView.frame = cell.contentView.bounds;;
    
    [cellView setIndividualInfo:_individual.avatar name:_individual.individualName];
}

-(void)makeInfoCells
{
    //    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    //    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeProfileCell)
    //                                                             makeTarget:self
    //                                                              actionSel:nil
    //                                                           actionTarget:self
    //                                                                 height:100.0f
    //                                                               userInfo:nil];
    //    cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
    //    [sectionInfo addCell:cellInfo];
    //
    //    [m_tableViewInfo addSection:sectionInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
