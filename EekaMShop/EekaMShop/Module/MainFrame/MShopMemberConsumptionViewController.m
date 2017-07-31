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
#import "MShopGetConsumptionItemsApi.h"
#import "MShopIndividualConsumptionModel.h"
#import "MShopIndividualConsumptionItemModel.h"
#import "MShopMemberConsumptionTitleView.h"
#import "MShopMemberConsumptionCellView.h"


@interface MShopMemberConsumptionViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
    NSMutableArray *_saleBillingItemArray;
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
    
    _saleBillingItemArray = [NSMutableArray array];
    [self getConsumptionItems];
}

-(void)getConsumptionItems
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetConsumptionItemsApi *mfApi = [MShopGetConsumptionItemsApi new];
    mfApi.individualId = self.individual.individualId;
    mfApi.animatingText = @"正在获取消费信息...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
        [_saleBillingItemArray removeAllObjects];
        NSArray *saleBillingList = request.responseObject[@"saleBillingList"];
        for (int i = 0; i < saleBillingList.count; i++) {
            MShopIndividualConsumptionModel *saleBillingItem = [MShopIndividualConsumptionModel MM_modelWithJSON:saleBillingList[i]];
            [_saleBillingItemArray addObject:saleBillingItem];
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
    
    if (_saleBillingItemArray.count == 0) {
        [self addBlankView];
        return;
    }
    
    MFTableViewSectionInfo *sectionInfo = [self addConsumptionSection];
    [m_tableViewInfo addSection:sectionInfo];
}

-(MFTableViewSectionInfo *)addConsumptionSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    
    for (int i = 0; i < _saleBillingItemArray.count; i++)
    {
        MShopIndividualConsumptionModel *saleBillingItem = _saleBillingItemArray[i];
        
        MFTableViewCellInfo *headerCellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeConsumptionTitleCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:nil
                                                               actionTarget:self
                                                                     height:60.0f
                                                                   userInfo:nil];
        
        [headerCellInfo addUserInfoValue:saleBillingItem forKey:@"saleBillingItem"];
        [sectionInfo addCell:headerCellInfo];
        
        for (int j = 0; j < saleBillingItem.itemList.count; j++) {
            
            MShopIndividualConsumptionItemModel *itemModel = saleBillingItem.itemList[j];
            
            MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeConsumptionCell:cellInfo:)
                                                                     makeTarget:self
                                                                      actionSel:@selector(onClickConsumptionCell:)
                                                                   actionTarget:self
                                                                         height:100.0f
                                                                       userInfo:nil];
            cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
            [cellInfo addUserInfoValue:itemModel forKey:@"MShopIndividualConsumptionItemModel"];
            
            [sectionInfo addCell:cellInfo];
        }
 
    }
    
    return sectionInfo;
}

-(void)makeConsumptionTitleCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopMemberConsumptionTitleView *cellView = [MShopMemberConsumptionTitleView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopMemberConsumptionTitleView *cellView = (MShopMemberConsumptionTitleView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopIndividualConsumptionModel *saleBillingItem = (MShopIndividualConsumptionModel *)[cellInfo getUserInfoValueForKey:@"saleBillingItem"];
    [cellView setIndividualConsumptionTitleModel:saleBillingItem];
}

-(void)makeConsumptionCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopMemberConsumptionCellView *cellView = [MShopMemberConsumptionCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopMemberConsumptionCellView *cellView = (MShopMemberConsumptionCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopIndividualConsumptionItemModel *saleBillingItem = (MShopIndividualConsumptionItemModel *)[cellInfo getUserInfoValueForKey:@"MShopIndividualConsumptionItemModel"];
    [cellView setIndividualConsumptionItem:saleBillingItem];
}

-(void)onClickConsumptionCell:(MFTableViewCellInfo *)cellInfo
{
    
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
    tipLabel.text = @"很抱歉，此会员还未消费。";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:tipLabel];
    
    cell.m_subContentView = contentView;
    contentView.frame = cell.contentView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
