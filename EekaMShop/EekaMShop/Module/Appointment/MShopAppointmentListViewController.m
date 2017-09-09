//
//  MShopAppointmentListViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentListViewController.h"
#import "MShopGetAppointmentListApi.h"
#import "MShopAppointmentDataItem.h"
#import "MShopMemberDetailViewController.h"
#import "MShopAppointmentModifyApi.h"
#import "MShopSendVerificationCodeApi.h"
#import "MShopDoPayAppointmentApi.h"
#import "MShopAppointmentFlexCellView.h"
#import "MFMultiMenuTableViewCell.h"
#import "MShopAppointmentDateSelectView.h"
#import "MShopAppointmentCodeInputView.h"

@interface MShopAppointmentListViewController () <UITableViewDataSource,UITableViewDelegate,LYSideslipCellDelegate,MShopAppointmentDateSelectViewDelegate,MShopAppointmentCodeInputViewDelegate>
{
    MFUITableView *_tableView;
    NSMutableArray *_appointmentList;
    
    UILabel *_navTitleLabel;
    
    NSInteger _pageIndex;
    NSInteger _pullPrePageIndex;
    NSInteger _pageSize;
    
    BOOL _hasFootBlankLine;
    
    MShopAppointmentDateSelectView *m_dateSelectView;
    MShopAppointmentCodeInputView *m_codeInputView;
    NSString *m_expectVerificationCode;
}

@end

@implementation MShopAppointmentListViewController

-(void)initPullToRefreshConfig
{
    _pageIndex = 0;
    _pageSize = 10;
    
    _pullPrePageIndex = _pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约列表";
    _appointmentList = [NSMutableArray array];
    [self initTableView];
    
    [self initPullToRefreshConfig];
    [self getAppointmentList];
}

-(void)initTableView
{
    _tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _appointmentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMultiMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MFShoppingCartItemCellView"];
    
    if (cell == nil) {
        cell = [[MFMultiMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MFShoppingCartItemCellView"];
        cell.delegate = self;
        
        MShopAppointmentFlexCellView *cellView = [MShopAppointmentFlexCellView new];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.frame;
    
    MShopAppointmentFlexCellView *cellView = (MShopAppointmentFlexCellView *)cell.m_subContentView;
    MShopAppointmentDataItem *dataItem = _appointmentList[indexPath.row];
    cellView.indexPath = indexPath;
    [cellView setAppointmentDataItem:dataItem];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MShopAppointmentDataItem *dataItem = _appointmentList[indexPath.row];
    [self showIndividualInfo:dataItem.individualId];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

#pragma mark - LYSideslipCellDelegate
- (NSArray<LYSideslipCellAction *> *)sideslipCell:(LYSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    NSMutableArray *actionArray = [NSMutableArray array];
    MShopAppointmentDataItem *dataItem = _appointmentList[indexPath.row];
    
    if (!dataItem.status) {
        return nil;
    }
    
    if ([dataItem.status isEqualToString:MShopAppointmentStatusPending])
    {
        LYSideslipCellAction *timeAction = [LYSideslipCellAction rowActionWithStyle:LYSideslipCellActionStyleNormal title:@"修改服务时间"
                                                                            handler:^(LYSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
                                            {
                                                [sideslipCell hiddenAllSideslip];
                                                [weakSelf showModifyTimeView:dataItem];
                                            }];
        [actionArray addObject:timeAction];
        
        LYSideslipCellAction *dopayAction = [LYSideslipCellAction rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"完成服务"
                                                                             handler:^(LYSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
                                             {
                                                 [sideslipCell hiddenAllSideslip];
                                                 [weakSelf doPayAppointment:dataItem];
                                             }];
        [actionArray addObject:dopayAction];
    }
    
    return actionArray;
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)getAppointmentList
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetAppointmentListApi *mfApi = [MShopGetAppointmentListApi new];
    [mfApi setPageIndex:_pageIndex pageSize:_pageSize];
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *appointments = [NSMutableArray array];
        NSArray *appointmentList = request.responseObject[@"appointmentList"];
        for (int i = 0; i < appointmentList.count; i++) {
            MShopAppointmentDataItem *dataItem = [MShopAppointmentDataItem MM_modelWithJSON:appointmentList[i]];
            [appointments addObject:dataItem];
        }
        
        [_appointmentList removeAllObjects];
        _appointmentList = appointments;
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
    
}

-(void)reloadTableView
{
    [self setNavTitle];
    [_tableView reloadData];
}

//-(void)reloadTableView
//{
//    [self setNavTitle];
//    
//    [m_tableViewInfo clearAllSection];
//    
//    if (_appointmentList.count > 0)
//    {
//        MFTableViewSectionInfo *sectionInfo = [self addAppointmentSection];
//        [m_tableViewInfo addSection:sectionInfo];
//        
//        if (_hasFootBlankLine)
//        {
//            [self addFootBlankLine];
//        }
//    }
//    else
//    {
//        [self addBlankView];
//    }
//}

//-(void)addFootBlankLine
//{
//    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
//    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeFootBlankLineCell:)
//                                                             makeTarget:self
//                                                              actionSel:nil
//                                                           actionTarget:self
//                                                                 height:30.0f
//                                                               userInfo:nil];
//    [sectionInfo addCell:cellInfo];
//    [m_tableViewInfo addSection:sectionInfo];
//}
//
//-(void)makeFootBlankLineCell:(MFTableViewCell *)cell
//{
//    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
//    contentView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *tipLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    tipLabel.textAlignment = NSTextAlignmentCenter;
//    tipLabel.text = @"已经到底了！";
//    tipLabel.font = [UIFont systemFontOfSize:15.0f];
//    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [contentView addSubview:tipLabel];
//    
//    cell.m_subContentView = contentView;
//    contentView.frame = cell.contentView.bounds;
//}
//
//-(void)addBlankView
//{
//    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
//    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeBlankCell:)
//                                                             makeTarget:self
//                                                              actionSel:nil
//                                                           actionTarget:self
//                                                                 height:200.0f
//                                                               userInfo:nil];
//    [sectionInfo addCell:cellInfo];
//    [m_tableViewInfo addSection:sectionInfo];
//}
//
//-(void)makeBlankCell:(MFTableViewCell *)cell
//{
//    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
//    contentView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *tipLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//    tipLabel.textAlignment = NSTextAlignmentCenter;
//    tipLabel.text = @"无预约记录";
//    tipLabel.font = [UIFont systemFontOfSize:16.0f];
//    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [contentView addSubview:tipLabel];
//    
//    cell.m_subContentView = contentView;
//    contentView.frame = cell.contentView.bounds;
//}
//
//-(MFTableViewSectionInfo *)addAppointmentSection
//{
//    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
//    for (int i = 0; i < _appointmentList.count; i++)
//    {
//        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeAppointmentCell:cellInfo:)
//                                                                 makeTarget:self
//                                                                  actionSel:@selector(onClickAppointmentCell:)
//                                                               actionTarget:self
//                                                                     height:150.0f
//                                                                   userInfo:nil];
//        cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
//        
//        MShopAppointmentDataItem *dataItem = _appointmentList[i];
//        [cellInfo addUserInfoValue:dataItem forKey:@"MShopAppointmentDataItem"];
//        
//        [sectionInfo addCell:cellInfo];
//    }
//    
//    return sectionInfo;
//}
//
//-(void)makeAppointmentCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
//{
//    MShopAppointmentFlexCellView *cellView = [MShopAppointmentFlexCellView new];
//    cell.m_subContentView = cellView;
//    cellView.frame = cell.contentView.bounds;
//    cellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    MShopAppointmentDataItem *dataItem = (MShopAppointmentDataItem *)[cellInfo getUserInfoValueForKey:@"MShopAppointmentDataItem"];
//    UITableView *tableView = [m_tableViewInfo getTableView];
//    cellView.indexPath = [tableView indexPathForCell:cell];
//    [cellView setAppointmentDataItem:dataItem];
//}

-(void)onClickAppointmentCell:(MFTableViewCellInfo *)cellInfo
{
    MShopAppointmentDataItem *dataItem = (MShopAppointmentDataItem *)[cellInfo getUserInfoValueForKey:@"MShopAppointmentDataItem"];
    [self showIndividualInfo:dataItem.individualId];
}

-(void)showIndividualInfo:(NSString *)individualId
{
    MShopMemberDetailViewController *memberDetailVC = [MShopMemberDetailViewController new];
    memberDetailVC.individualId = individualId;
    memberDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:memberDetailVC animated:YES];
}

-(NSString *)verificationCodePhone:(NSString *)phone
{
    return @"13425148460";
//    return phone;
}

-(void)doPayAppointment:(MShopAppointmentDataItem *)dataItem
{
    MShopDoPayAppointmentApi *mfApi = [MShopDoPayAppointmentApi new];
    mfApi.phone = [self verificationCodePhone:dataItem.individualPhone];
    mfApi.individualId = dataItem.individualId;
    mfApi.type = dataItem.type;
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        m_expectVerificationCode = [mfApi verificationCode];
        [strongSelf showVerificationCodeInputView:dataItem verificationCode:m_expectVerificationCode];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)showVerificationCodeInputView:(MShopAppointmentDataItem *)dataItem verificationCode:(NSString *)expectVerificationCode
{
    if (!m_codeInputView) {
        m_codeInputView = [MShopAppointmentCodeInputView nibView];
        m_codeInputView.m_delegate = self;
    }
    
    m_codeInputView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:m_codeInputView];
    
    m_codeInputView.numberOfVertificationCode = expectVerificationCode.length;
    [m_codeInputView setAppointmentDataItem:dataItem];
}

#pragma mark - MShopAppointmentCodeInputViewDelegate
-(void)onClickResendVerificationCode:(NSString *)phone
{
    MShopSendVerificationCodeApi *mfApi = [MShopSendVerificationCodeApi new];
    mfApi.phone = [self verificationCodePhone:phone];
    mfApi.animatingText = @"正在重发验证码";
    mfApi.animatingView = MFAppWindow;
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        m_expectVerificationCode = [mfApi verificationCode];
        [strongSelf showTips:@"验证码发送成功"];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)showModifyTimeView:(MShopAppointmentDataItem *)dataItem
{
    if (!m_dateSelectView) {
        m_dateSelectView = [MShopAppointmentDateSelectView nibView];
        m_dateSelectView.m_delegate = self;
    }
    
    m_dateSelectView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:m_dateSelectView];
    
    [m_dateSelectView setAppointmentDataItem:dataItem];
}

#pragma mark - MShopAppointmentDateSelectViewDelegate
-(void)didSetAppointmentDate:(NSString *)appointmentDate appointmentTime:(NSString *)appointmentTime selectView:(MShopAppointmentDateSelectView *)selectView
{
    MShopAppointmentDataItem *dataItem = [selectView appointmentDataItem];
    dataItem.appointmentDate = appointmentDate;
    dataItem.appointmentTime = appointmentTime;
    
    [self modifyAppointment:dataItem];
}

-(void)modifyAppointment:(MShopAppointmentDataItem *)dataItem
{
    MShopAppointmentModifyApi *mfApi = [MShopAppointmentModifyApi new];
    mfApi.animatingView = MFAppWindow;
    mfApi.dataItem = dataItem;
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"修改成功！"];
        [strongSelf getAppointmentList];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)setNavTitle
{
    NSString *title = @"预约列表";
    if (_appointmentList.count > 0) {
        title = [NSString stringWithFormat:@"预约列表(%@)",@(_appointmentList.count)];
    }
    
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _navTitleLabel.textColor = [UIColor whiteColor];
        [self.navigationItem setTitleView:_navTitleLabel];
    }
    
    _navTitleLabel.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
