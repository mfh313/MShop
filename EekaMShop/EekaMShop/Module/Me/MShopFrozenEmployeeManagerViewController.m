//
//  MShopFrozenEmployeeManagerViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopFrozenEmployeeManagerViewController.h"
#import "MShopGetFrozenEmployeeListApi.h"
#import "MShopFrozenOptEmployeeApi.h"
#import "MShopFrozenEmployeeModel.h"
#import "MShopGetEmployeeListApi.h"
#import "MShopLoginService.h"
#import "MShopFrozenEmployeeCellView.h"

@interface MShopFrozenEmployeeManagerViewController () <MShopFrozenEmployeeCellViewDelegate>
{
    MFTableViewInfo *m_tableViewInfo;
    NSMutableArray *_frozenEmployeeList;
}

@end

@implementation MShopFrozenEmployeeManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"员工冻结管理";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _frozenEmployeeList = [NSMutableArray array];
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    [self sendFrozenBatchRequest];
}

- (void)sendFrozenBatchRequest
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *currentLoginUserInfo = [loginService currentLoginUserInfo];
    
    MShopGetEmployeeListApi *employeeListApi = [MShopGetEmployeeListApi new];
    employeeListApi.deptId = [loginService currentLoginUserDepartment];
    
    MShopGetFrozenEmployeeListApi *getFrozenEmployeeApi = [MShopGetFrozenEmployeeListApi new];
    
    __weak typeof(self) weakSelf = self;
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[employeeListApi, getFrozenEmployeeApi]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest)
    {
        NSArray *requests = batchRequest.requestArray;
        
        MShopGetEmployeeListApi *employeeListApi = (MShopGetEmployeeListApi *)requests[0];
        NSArray *employeeList = employeeListApi.responseObject[@"employeeList"];
        
        MShopGetFrozenEmployeeListApi *frozenEmployeeListApi = (MShopGetFrozenEmployeeListApi *)requests[1];
        NSArray *frozenList = frozenEmployeeListApi.responseObject[@"employeeList"];
        
        
        
        
        
        [_frozenEmployeeList removeAllObjects];
        for (int i = 0; i < employeeList.count; i++) {
            MShopFrozenEmployeeModel *employeeInfo = [MShopFrozenEmployeeModel MM_modelWithJSON:employeeList[i]];
            
            if (![currentLoginUserInfo.userId isEqualToString:employeeInfo.userId])
            {
                [_frozenEmployeeList addObject:employeeInfo];
            }
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf reloadTableView];
        
    } failure:^(YTKBatchRequest *batchRequest) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"同时请求失败"];
        [self showTips:errorDesc];
    }];
}


-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    MFTableViewSectionInfo *sectionInfo = [self addEmployeeSection];
    [m_tableViewInfo addSection:sectionInfo];
}

- (MFTableViewSectionInfo *)addEmployeeSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    for (int i = 0; i < _frozenEmployeeList.count; i++)
    {
        MShopFrozenEmployeeModel *frozenEmployeeInfo = _frozenEmployeeList[i];
        
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeFrozenEmployeeInfoCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:nil
                                                               actionTarget:nil
                                                                     height:70.0f
                                                                   userInfo:nil];
        [cellInfo addUserInfoValue:frozenEmployeeInfo forKey:@"MShopFrozenEmployeeModel"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    return sectionInfo;
}

-(void)makeFrozenEmployeeInfoCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopFrozenEmployeeCellView *cellView = [MShopFrozenEmployeeCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopFrozenEmployeeCellView *cellView = (MShopFrozenEmployeeCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopFrozenEmployeeModel *employeeInfo = (MShopFrozenEmployeeModel *)[cellInfo getUserInfoValueForKey:@"MShopFrozenEmployeeModel"];
    [cellView setEmployeeInfo:employeeInfo];
}

#pragma mark - MShopFrozenEmployeeCellViewDelegate
-(void)onClickFrozenEmployee:(MShopFrozenEmployeeModel *)employeeInfo
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
