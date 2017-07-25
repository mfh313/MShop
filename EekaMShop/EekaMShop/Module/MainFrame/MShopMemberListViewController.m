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
#import "MShopUISearchBar.h"
#import "MShopSearchIndividualApi.h"

@interface MShopMemberListViewController ()
{
    NSMutableArray *_individualArray;
    MFTableViewInfo *m_tableViewInfo;
    MShopUISearchBar *m_searchBar;
}

@end

@implementation MShopMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员列表";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    CGRect tableFrame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    [self makeSearchBar];
    
    _individualArray = [NSMutableArray array];
    
     [self getIndividualList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getIndividualList];
}

-(void)makeSearchBar
{
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    
    m_searchBar = [[MShopUISearchBar alloc] init];
    m_searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
    m_searchBar.placeholder = @"精确搜索手机号";
    m_searchBar.delegate = self;
    contentTableView.tableHeaderView = m_searchBar;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        NSString *searchText = searchBar.text;
        [self searchIndividualInfo:searchText];
        return NO;
    }
    return YES;
}

-(void)searchIndividualInfo:(NSString *)searchText
{
    searchText = @"15813818620";
    
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
        
        
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getIndividualList
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetMemberListApi *getMemberListApi = [MShopGetMemberListApi new];
    getMemberListApi.animatingText = @"正在获取会员列表...";
    getMemberListApi.animatingView = MFAppWindow;
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
    cellView.frame = cell.contentView.bounds;;
    
    MShopIndividualInfo *individual = (MShopIndividualInfo *)[cellInfo getUserInfoValueForKey:@"individual"];
    [cellView setIndividualInfo:individual];
}

-(void)onClickMemberListCell:(MFTableViewCellInfo *)cellInfo
{
    MShopIndividualInfo *individual = (MShopIndividualInfo *)[cellInfo getUserInfoValueForKey:@"individual"];
    
    MShopMemberDetailViewController *memberDetailVC = [MShopMemberDetailViewController new];
    memberDetailVC.individual = individual;
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:MFImageStretchCenter(@"button_normal") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickblankBtn) forControlEvents:UIControlEventTouchUpInside];
    button.frame = contentView.bounds;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [button setTitle:@"无会员,点击开始搜索" forState:UIControlStateNormal];
    
    [contentView addSubview:button];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;;
}

-(void)onClickblankBtn
{
    [m_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
