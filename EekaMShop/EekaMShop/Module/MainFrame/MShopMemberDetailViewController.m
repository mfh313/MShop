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
#import "MShopMemberDetailCellView.h"
#import "MShopMemberConsumptionViewController.h"

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
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    if (self.individual)
    {
        [self makeMemberInfoViews];
    }
    else
    {
        [self getIndividualInfo];
    }
}

-(void)makeMemberInfoViews
{
    [self makeInfoSection];
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
        [strongSelf getIndividualInfo];
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)makeInfoSection
{
    [m_tableViewInfo clearAllSection];
    
    [self makeProfileCell];
    
    [self makeIndividualConsumptionSection];
    
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    
    //手机号
    MFTableViewCellInfo *phoneCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                             makeTarget:self
                                              actionSel:@selector(onClickPhoneCell)
                                           actionTarget:self
                                                 height:44.0
                                               userInfo:nil];
    [phoneCellInfo addUserInfoValue:@"手机号" forKey:@"title"];
    [phoneCellInfo addUserInfoValue:self.individual.phone forKey:@"rightValue"];
    
    //性别
    MFTableViewCellInfo *sexCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                                                  makeTarget:self
                                                                   actionSel:nil
                                                                actionTarget:nil
                                                                      height:44.0
                                                                    userInfo:nil];
    [sexCellInfo addUserInfoValue:@"性别" forKey:@"title"];
    [sexCellInfo addUserInfoValue:[self.individual genderDescribe] forKey:@"rightValue"];

    //出生日期
    MFTableViewCellInfo *birthdayCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                                                makeTarget:self
                                                                 actionSel:nil
                                                              actionTarget:nil
                                                                    height:44.0
                                                                  userInfo:nil];
    [birthdayCellInfo addUserInfoValue:@"出生日期" forKey:@"title"];
    [birthdayCellInfo addUserInfoValue:self.individual.birthday forKey:@"rightValue"];
    
    //住址
    MFTableViewCellInfo *addressCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                                                     makeTarget:self
                                                                      actionSel:nil
                                                                   actionTarget:nil
                                                                         height:44.0
                                                                       userInfo:nil];
    [addressCellInfo addUserInfoValue:@"住址" forKey:@"title"];
    [addressCellInfo addUserInfoValue:self.individual.address forKey:@"rightValue"];
    
    
    [sectionInfo addCell:phoneCellInfo];
    [sectionInfo addCell:sexCellInfo];
    [sectionInfo addCell:birthdayCellInfo];
    [sectionInfo addCell:addressCellInfo];
    
    if (self.individual.maintainDeptId) {
        //维护店铺
        MFTableViewCellInfo *maintainDeptNameCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                                                        makeTarget:self
                                                                         actionSel:nil
                                                                      actionTarget:nil
                                                                            height:44.0
                                                                          userInfo:nil];
        [maintainDeptNameCellInfo addUserInfoValue:@"维护店铺" forKey:@"title"];
        [maintainDeptNameCellInfo addUserInfoValue:self.individual.maintainDeptName forKey:@"rightValue"];
        
        //维护员工
        MFTableViewCellInfo *maintainEmployeeNameCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeNormalCell:cellInfo:)
                                                                                 makeTarget:self
                                                                                  actionSel:nil
                                                                               actionTarget:nil
                                                                                     height:44.0
                                                                                   userInfo:nil];
        [maintainEmployeeNameCellInfo addUserInfoValue:@"维护员工" forKey:@"title"];
        [maintainEmployeeNameCellInfo addUserInfoValue:self.individual.maintainEmployeeName forKey:@"rightValue"];
        
        [sectionInfo addCell:maintainDeptNameCellInfo];
        [sectionInfo addCell:maintainEmployeeNameCellInfo];
    }
    
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

-(void)makeIndividualConsumptionSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    
    MFTableViewCellInfo *individualConsumptionCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeIndividualConsumptionCell:cellInfo:)
                                                                                  makeTarget:self
                                                                                   actionSel:@selector(onClickIndividualConsumption)
                                                                                actionTarget:self
                                                                                      height:80
                                                                                    userInfo:nil];
    [sectionInfo addCell:individualConsumptionCellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)makeIndividualConsumptionCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    contentView.backgroundColor = [UIColor whiteColor];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(contentView.frame) - 20, CGRectGetHeight(contentView.frame))];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.text = @"会员消费记录";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:tipLabel];
    
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowBtn setImage:MFImage(@"arrow") forState:UIControlStateNormal];
    arrowBtn.frame = CGRectMake(CGRectGetWidth(contentView.frame) - 9 - 15, (cellInfo.fCellHeight - 16) / 2, 9, 16);
    arrowBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [contentView addSubview:arrowBtn];
    
    [self addOnePixLine:contentView];
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
    cellView.frame = cell.contentView.bounds;
    
    [cellView setIndividualInfo:_individual.avatar name:_individual.individualName];
}

-(void)makeNormalCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopMemberDetailCellView *cellView = [MShopMemberDetailCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopMemberDetailCellView *cellView = (MShopMemberDetailCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    NSString *title =  [cellInfo getUserInfoValueForKey:@"title"];
    NSString *rightValue =  [cellInfo getUserInfoValueForKey:@"rightValue"];
    [cellView setTitle:title rightValue:rightValue];
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
            if ([currentLoginUserInfo isShopKeeper])
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
    if (![currentLoginUserInfo isShopKeeper]) {
        buttonTitle = @"分配给自己";
    }
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [contentView addSubview:button];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
    contentView.backgroundColor = [UIColor whiteColor];
}

-(void)addOnePixLine:(UIView *)contentView
{
    MMOnePixLine *onePixLine = [MMOnePixLine new];
    onePixLine.frame = CGRectMake(0, CGRectGetHeight(contentView.bounds) - MFOnePixHeight, CGRectGetWidth(contentView.bounds), MFOnePixHeight);
    onePixLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    onePixLine.backgroundColor = [UIColor clearColor];
    [contentView addSubview:onePixLine];
}

-(void)onClickIndividualModifyBtn
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
    if (![currentLoginUserInfo isShopKeeper])
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
    
    if (self.individual)
    {
        getIndividualApi.individualId = self.individual.individualId;
    }
    else
    {
        getIndividualApi.individualId = self.individualId;
    }
    
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

-(void)onClickIndividualConsumption
{
    MShopMemberConsumptionViewController *consumptionVC = [MShopMemberConsumptionViewController new];
    consumptionVC.individual = self.individual;
    consumptionVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:consumptionVC animated:YES];
}

-(void)onClickPhoneCell
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.individual.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
