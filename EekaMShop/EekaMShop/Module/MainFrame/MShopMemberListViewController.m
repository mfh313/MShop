//
//  MShopMemberListViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberListViewController.h"
#import "MShopGetMemberListApi.h"
#import "MShopIndividualInfo.h"
#import "MShopMemberListCellView.h"
#import "MShopMemberDetailViewController.h"
#import "MFTableViewInfo.h"
#import "MShopSearchIndividualApi.h"
#import "MShopMemberSearchBar.h"
#import "MShopMemberListCellView.h"
#import "MShopMemberListFreshDelegate.h"

@interface MShopMemberListViewController ()<MFTableViewInfoDelegate,MMSearchBarDelegate,MShopMemberListFreshDelegate>
{
    NSMutableArray *_individualArray;
    MFTableViewInfo *m_tableViewInfo;
    MShopMemberSearchBar *m_mmSearchBar;
    NSMutableArray *_searchIndividualArray;
}

@end

@implementation MShopMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员列表";
    
    if (self.navigationController.viewControllers.count > 1) {
        [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    }
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    m_mmSearchBar = [[MShopMemberSearchBar alloc] initWithContentsController:self];
    m_mmSearchBar.m_delegate = self;
    contentTableView.tableHeaderView = m_mmSearchBar.m_searchBar;
    
    _individualArray = [NSMutableArray array];
    _searchIndividualArray = [NSMutableArray array];
    [self getIndividualList];
}

#pragma mark - MShopMemberListFreshDelegate
-(void)freshMemberList
{
    [self getIndividualList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self shouldShowTabbar]) {
        [[MShopAppViewControllerManager getTabBarController] showTabBar];
    }
}

#pragma mark - MMSearchBarDelegate
-(void)SearchBarBecomeActive
{
    [[MShopAppViewControllerManager getTabBarController] hideTabBar];
}

-(void)cancelSearch
{
    [[MShopAppViewControllerManager getTabBarController] showTabBar];
}

- (void)doSearch:(NSString *)searchText Pre:(BOOL)pre
{
    [_searchIndividualArray removeAllObjects];
    
    [m_mmSearchBar hideSearchGuideView];
    [self doSearchIndividual:searchText];
}

- (BOOL)mmsearchBarShouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [m_mmSearchBar hideSearchGuideView];
        [self doSearchIndividual:m_mmSearchBar.m_nsLastSearchText];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkStrLimitFourNumber:(NSString *)str
{
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *numberRegex = @"[0-9]+";
    NSPredicate *numberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    
    if ([numberPred evaluateWithObject:str])
    {
//        NSString *regex = @"[0-9]{4,}"; //至少四位数字
        NSString *regex = @"1[3|4|5|7|8][0-9]\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        BOOL isMatch = [pred evaluateWithObject:str];
        
        if (!isMatch) {
            return NO;
        }
        return YES;
    }
    
    return YES;
}

-(void)doSearchIndividual:(NSString *)searchText
{
    if ([MFStringUtil isBlankString:searchText]) {
        return;
    }
    
    if (![self checkStrLimitFourNumber:searchText]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    MShopSearchIndividualApi *searchIndividualApi = [MShopSearchIndividualApi new];
    searchIndividualApi.searchKey = searchText;
    searchIndividualApi.animatingView = MFAppWindow;
    [searchIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!searchIndividualApi.messageSuccess) {
            [self showTips:searchIndividualApi.errorMessage];
            return;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [_searchIndividualArray removeAllObjects];
        NSArray *individualList = request.responseObject[@"individualList"];
        for (int i = 0; i < individualList.count; i++) {
            MShopIndividualInfo *individual = [MShopIndividualInfo MM_modelWithJSON:individualList[i]];
            [_searchIndividualArray addObject:individual];
        }
        
        [strongSelf reloadSearchResultsTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadSearchResultsTableView
{
    [m_mmSearchBar.m_searchDisplayController.searchResultsTableView reloadData];
}

-(NSInteger)numberOfSectionsForSearchViewTable:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView
{
    return _searchIndividualArray.count;
}

-(UITableViewCell *)cellForIndex:(NSIndexPath *)indexPath ForSearchViewTable:(UITableView *)tableView
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MShopMemberListCellView"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MShopMemberListCellView"];
        MShopMemberListCellView *cellView = [MShopMemberListCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    MShopMemberListCellView *cellView = (MShopMemberListCellView *)cell.m_subContentView;
    MShopIndividualInfo *individual = _searchIndividualArray[indexPath.row];
    
    [cellView setIndividualInfo:individual];
    return cell;
}

-(CGFloat)heightForSearchViewTable:(NSIndexPath *)indexPath
{
    return 72.0f;
}

- (void)didSearchViewTableSelect:(NSIndexPath *)indexPath
{
    MShopIndividualInfo *individual = _searchIndividualArray[indexPath.row];
    [self showIndividualInfo:individual];
}

-(void)getIndividualList
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetMemberListApi *getMemberListApi = [MShopGetMemberListApi new];
    [getMemberListApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!getMemberListApi.messageSuccess) {
            [self showTips:getMemberListApi.errorMessage];
            return;
        }
        
        [_individualArray removeAllObjects];
        
        NSArray *individualList = request.responseObject[@"individualList"];
        for (int i = 0; i < individualList.count; i++) {
            MShopIndividualInfo *individual = [MShopIndividualInfo MM_modelWithJSON:individualList[i]];
            [_individualArray addObject:individual];
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    if (_individualArray.count == 0) {
        [self addBlankView];
        return;
    }
    
    MFTableViewSectionInfo *sectionInfo = [self addMemberSection];
    [m_tableViewInfo addSection:sectionInfo];
}

- (MFTableViewSectionInfo *)addMemberSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    for (int i = 0; i < _individualArray.count; i++)
    {
        MShopIndividualInfo *individual = _individualArray[i];
        
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeMemberListCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(onClickMemberListCell:)
                                                               actionTarget:self
                                                                     height:72.0f
                                                                   userInfo:nil];
        cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
        [cellInfo addUserInfoValue:individual forKey:@"individual"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    return sectionInfo;
}

-(void)makeMemberListCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopMemberListCellView *cellView = [MShopMemberListCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopMemberListCellView *cellView = (MShopMemberListCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopIndividualInfo *individual = (MShopIndividualInfo *)[cellInfo getUserInfoValueForKey:@"individual"];
    [cellView setIndividualInfo:individual];
}

-(void)onClickMemberListCell:(MFTableViewCellInfo *)cellInfo
{
    MShopIndividualInfo *individual = (MShopIndividualInfo *)[cellInfo getUserInfoValueForKey:@"individual"];
    [self showIndividualInfo:individual];
}

-(void)showIndividualInfo:(MShopIndividualInfo *)individual
{
    MShopMemberDetailViewController *memberDetailVC = [MShopMemberDetailViewController new];
    memberDetailVC.individual = individual;
    memberDetailVC.m_delegate = self;
    memberDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:memberDetailVC animated:YES];
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
    tipLabel.text = @"还没有会员,开始搜索添加会员吧！";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:tipLabel];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
}

- (BOOL)isSeachActive
{
    return m_mmSearchBar.m_searchDisplayController.isActive;
}

- (BOOL)shouldShowTabbar
{
    return ![self isSeachActive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
