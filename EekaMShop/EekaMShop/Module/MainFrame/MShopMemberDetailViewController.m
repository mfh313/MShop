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
#import "MShopGetIndividualApi.h"
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
    
    CGRect tableFrame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    [self makeMemberInfoViews];
}

-(void)makeMemberInfoViews
{
    [self makeInfoCells];
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
    self.individual.maintainDeptId = [self depIdForDepartment:employeeInfo.department];
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

-(void)makeInfoCells
{
    [m_tableViewInfo clearAllSection];
    
    [self makeProfileCell];
    
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    
    MFTableViewCellInfo *phoneCellInfo = [MFTableViewCellInfo
                                          normalCellForSel:nil
                                          target:self
                                          title:@"手机号"
                                          rightValue:self.individual.phone
                                          accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    MFTableViewCellInfo *sexCellInfo = [MFTableViewCellInfo
                                          normalCellForSel:nil
                                          target:self
                                          title:@"性别"
                                          rightValue:self.individual.gender
                                          accessoryType:UITableViewCellAccessoryNone];

    
    
    
    
    [sectionInfo addCell:phoneCellInfo];
    [sectionInfo addCell:sexCellInfo];
    
    if ([self needSelectMaintainEmployeePowerCell])
    {
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeSelectMaintainEmployeeCell:)
                                                                 makeTarget:self
                                                                  actionSel:nil
                                                               actionTarget:self
                                                                     height:60.0f
                                                                   userInfo:nil];
        [sectionInfo addCell:cellInfo];
    }
    
    [m_tableViewInfo addSection:sectionInfo];
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

-(void)makeNormalCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    
}

-(BOOL)needSelectMaintainEmployeePowerCell
{
    if (!self.individual.maintainDeptId)
    {
        return YES;
    }
    else
    {
        MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
        MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
        
        if ([[self depIdForDepartment:currentLoginUserInfo.department] isEqualToString:self.individual.maintainDeptId])
        {
            if ([currentLoginUserInfo.position isEqualToString:@"店长"])
            {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)makeSelectMaintainEmployeeCell:(MFTableViewCell *)cell
{
    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:MFImageStretchCenter(@"button_normal") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickIndividualModifyBtn) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(40, 10, CGRectGetWidth(contentView.frame) - 80, CGRectGetHeight(contentView.frame) - 20);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSString *buttonTitle = @"分配会员";
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
    if (![currentLoginUserInfo.position isEqualToString:@"店长"]) {
        buttonTitle = @"分配给自己";
    }
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [contentView addSubview:button];
    
    MMOnePixLine *onePixLine = [MMOnePixLine new];
    onePixLine.frame = CGRectMake(0, CGRectGetHeight(contentView.bounds) - MFOnePixHeight, CGRectGetWidth(contentView.bounds), MFOnePixHeight);
    onePixLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    onePixLine.backgroundColor = [UIColor clearColor];
    [contentView addSubview:onePixLine];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;;
}

-(void)onClickIndividualModifyBtn
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
    if (![currentLoginUserInfo.position isEqualToString:@"店长"])
    {
        [self onDidSelectEmployee:currentLoginUserInfo];
    }
    else
    {
        [self selectMaintainEmployee];
    }
}

-(NSString *)depIdForDepartment:(NSString *)department
{
    NSString *stringArray = [department substringWithRange:(NSRange){1,department.length - 2}];
    return [stringArray componentsSeparatedByString:@","].firstObject;
}

-(void)getIndividualInfo
{
    __weak typeof(self) weakSelf = self;
    MShopGetIndividualApi *getIndividualApi = [MShopGetIndividualApi new];
    getIndividualApi.individualId = self.individual.individualId;
    getIndividualApi.animatingView = MFAppWindow;
    [getIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!getIndividualApi.messageSuccess) {
            [self showTips:getIndividualApi.errorMessage];
            return;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        MShopIndividualInfo *individual = [MShopIndividualInfo MM_modelWithJSON:request.responseObject];
        _individual = individual;
        [strongSelf makeMemberInfoViews];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
