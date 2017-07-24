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

@interface MShopMemberListViewController ()
{
    NSMutableArray *_individualArray;
    MFTableViewInfo *m_tableViewInfo;
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
    
    _individualArray = [NSMutableArray array];
    [self getIndividualList];
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
        
//        for (int i = 0; i < 40; i++) {
//            [sectionInfo addCell:cellInfo];
//        }
        [sectionInfo addCell:cellInfo];
    }
    
    return sectionInfo;
}

-(void)makeMemberListCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    MShopMemberListCellView *cellView = [MShopMemberListCellView nibView];
    cell.m_subContentView = cellView;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
