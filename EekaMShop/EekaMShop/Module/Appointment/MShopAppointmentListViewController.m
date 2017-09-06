//
//  MShopAppointmentListViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentListViewController.h"
#import "MFTableViewInfo.h"
#import "MShopGetAppointmentListApi.h"
#import "MShopAppointmentDataItem.h"
#import "MShopMemberDetailViewController.h"
#import "MShopAppointmentCellView.h"
#import "MShopAppointmentModifyApi.h"
#import "MShopSendVerificationCodeApi.h"
#import "MShopDoPayAppointmentApi.h"

@interface MShopAppointmentListViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
    NSMutableArray *_appointmentList;
    
    UILabel *_navTitleLabel;
    
    NSInteger _pageIndex;
    NSInteger _pullPrePageIndex;
    NSInteger _pageSize;
    
    BOOL _hasFootBlankLine;
}

@end

@implementation MShopAppointmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约列表";
        
    _appointmentList = [NSMutableArray array];
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    contentTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:contentTableView];
    
    __weak MShopAppointmentListViewController *weakSelf = self;
    [contentTableView addPullToRefreshWithActionHandler:^{
        [weakSelf initPullToRefreshConfig];
        [weakSelf getAppointmentList];
    }];
    
    [contentTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullUpConfig];
        [weakSelf pullUPAppointmentList];
    }];

    [contentTableView triggerPullToRefresh];
}

-(void)initPullToRefreshConfig
{
    _pageIndex = 0;
    _pageSize = 5;
    
    _pullPrePageIndex = _pageIndex;
}

-(void)pullUpConfig
{
    _pullPrePageIndex++;
}

-(void)pullUPAppointmentList
{
    MShopGetAppointmentListApi *mfApi = [MShopGetAppointmentListApi new];
    
    [mfApi setPageIndex:_pullPrePageIndex pageSize:_pageSize];
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {

        UITableView *tableView = [m_tableViewInfo getTableView];
        [tableView.infiniteScrollingView stopAnimating];
        
        if (!mfApi.messageSuccess) {
            [weakSelf showTips:mfApi.errorMessage];
            _pullPrePageIndex--;
            return;
        }
        
        NSArray *appointmentList = request.responseObject[@"appointmentList"];
        NSMutableArray *pullAppointmentList = [NSMutableArray array];
        
        for (int i = 0; i < appointmentList.count; i++) {
            MShopAppointmentDataItem *dataItem = [MShopAppointmentDataItem MM_modelWithJSON:appointmentList[i]];
            [pullAppointmentList addObject:dataItem];
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (pullAppointmentList.count > 0)
        {
            [_appointmentList addObjectsFromArray:pullAppointmentList];
            
            _hasFootBlankLine = NO;
        }
        else
        {
            _hasFootBlankLine = YES;
        }
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        _pullPrePageIndex--;
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

-(void)getAppointmentList
{
    MShopGetAppointmentListApi *mfApi = [MShopGetAppointmentListApi new];
    mfApi.animatingView = MFAppWindow;
    [mfApi setPageIndex:_pageIndex pageSize:_pageSize];
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        UITableView *tableView = [m_tableViewInfo getTableView];
        [tableView.pullToRefreshView stopAnimating];
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
        [_appointmentList removeAllObjects];
        
        NSArray *appointmentList = request.responseObject[@"appointmentList"];
        for (int i = 0; i < appointmentList.count; i++) {
            MShopAppointmentDataItem *dataItem = [MShopAppointmentDataItem MM_modelWithJSON:appointmentList[i]];
            [_appointmentList addObject:dataItem];
        }
        
        _hasFootBlankLine = NO;
        
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
    
    [m_tableViewInfo clearAllSection];
    
    if (_appointmentList.count > 0)
    {
        MFTableViewSectionInfo *sectionInfo = [self addAppointmentSection];
        [m_tableViewInfo addSection:sectionInfo];
        
        if (_hasFootBlankLine)
        {
            [self addFootBlankLine];
        }
    }
    else
    {
        [self addBlankView];
    }
}

-(void)addFootBlankLine
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeFootBlankLineCell:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:30.0f
                                                               userInfo:nil];
    [sectionInfo addCell:cellInfo];
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)makeFootBlankLineCell:(MFTableViewCell *)cell
{
    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"已经到底了！";
    tipLabel.font = [UIFont systemFontOfSize:15.0f];
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:tipLabel];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
}

-(void)addBlankView
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeBlankCell:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:200.0f
                                                               userInfo:nil];
    [sectionInfo addCell:cellInfo];
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)makeBlankCell:(MFTableViewCell *)cell
{
    UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"无预约记录";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:tipLabel];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
}

-(MFTableViewSectionInfo *)addAppointmentSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    for (int i = 0; i < _appointmentList.count; i++)
    {
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeAppointmentCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(onClickAppointmentCell:)
                                                               actionTarget:self
                                                                     height:90.0f
                                                                   userInfo:nil];
        cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
        
        MShopAppointmentDataItem *dataItem = _appointmentList[i];
        [cellInfo addUserInfoValue:dataItem forKey:@"MShopAppointmentDataItem"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    return sectionInfo;
}

-(void)makeAppointmentCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopAppointmentCellView *cellView = [MShopAppointmentCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopAppointmentCellView *cellView = (MShopAppointmentCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopAppointmentDataItem *dataItem = (MShopAppointmentDataItem *)[cellInfo getUserInfoValueForKey:@"MShopAppointmentDataItem"];
    [cellView setAppointmentDataItem:dataItem];
}

-(void)onClickAppointmentCell:(MFTableViewCellInfo *)cellInfo
{
    MShopAppointmentDataItem *dataItem = (MShopAppointmentDataItem *)[cellInfo getUserInfoValueForKey:@"MShopAppointmentDataItem"];
//    [self showIndividualInfo:dataItem.individualId];
//    [self doPayAppointment:dataItem];
    [self sendVerificationCode:dataItem.individualPhone];
}

-(void)showIndividualInfo:(NSString *)individualId
{
    MShopMemberDetailViewController *memberDetailVC = [MShopMemberDetailViewController new];
    memberDetailVC.individualId = individualId;
    memberDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:memberDetailVC animated:YES];
}

-(void)doPayAppointment:(MShopAppointmentDataItem *)dataItem
{
    MShopDoPayAppointmentApi *mfApi = [MShopDoPayAppointmentApi new];
    mfApi.animatingView = MFAppWindow;
    
    mfApi.phone = dataItem.individualPhone;
    mfApi.individualId = dataItem.individualId;
    mfApi.type = dataItem.type;
    
    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
        NSString *expectVerificationCode = [mfApi verificationCode];
        NSLog(@"expectVerificationCode=%@",expectVerificationCode);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showVerificationCodeInputView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)sendVerificationCode:(NSString *)phone
{
    phone = @"13798228953";
    
    MShopSendVerificationCodeApi *mfApi = [MShopSendVerificationCodeApi new];
    mfApi.animatingView = MFAppWindow;
    mfApi.phone = phone;

    __weak typeof(self) weakSelf = self;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSString *expectVerificationCode = [mfApi verificationCode];
        NSLog(@"expectVerificationCode=%@",expectVerificationCode);
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)showVerificationCodeInputView
{
    
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
