//
//  MShopEmployeeListViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopEmployeeListViewController.h"
#import "MShopEmployeeInfo.h"
#import "MFTableViewInfo.h"
#import "MShopGetEmployeeListApi.h"
#import "MShopLoginService.h"
#import "MShopEmployeeInfoCellView.h"

@interface MShopEmployeeListViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
    NSMutableArray *_employees;
}

@end

@implementation MShopEmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择导购";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentTableView];
    
    _employees = [NSMutableArray array];
    [self getEmployeesList];
}

-(void)getEmployeesList
{
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    
    MShopGetEmployeeListApi *employeeListApi = [MShopGetEmployeeListApi new];
    employeeListApi.deptId = [loginService currentLoginUserDepartment];
    employeeListApi.animatingView = MFAppWindow;
    
    __weak typeof(self) weakSelf = self;
    [employeeListApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!employeeListApi.messageSuccess) {
            [self showTips:employeeListApi.errorMessage];
            return;
        }
        
        [_employees removeAllObjects];
        
        NSArray *employeeList = request.responseObject[@"employeeList"];
        for (int i = 0; i < employeeList.count; i++) {
            MShopEmployeeInfo *employeeInfo = [MShopEmployeeInfo MM_modelWithJSON:employeeList[i]];
            [_employees addObject:employeeInfo];
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
    
    MFTableViewSectionInfo *sectionInfo = [self addEmployeeSection];
    [m_tableViewInfo addSection:sectionInfo];
}

- (MFTableViewSectionInfo *)addEmployeeSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    for (int i = 0; i < _employees.count; i++)
    {
        MShopEmployeeInfo *employeeInfo = _employees[i];
        
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeEmployeeInfoCell:cellInfo:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(onClickEmployeeInfoCell:)
                                                               actionTarget:self
                                                                     height:70.0f
                                                                   userInfo:nil];
        cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
        [cellInfo addUserInfoValue:employeeInfo forKey:@"MShopEmployeeInfo"];
        
        [sectionInfo addCell:cellInfo];
    }
    
    return sectionInfo;
}

-(void)makeEmployeeInfoCell:(MFTableViewCell *)cell cellInfo:(MFTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        MShopEmployeeInfoCellView *cellView = [MShopEmployeeInfoCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopEmployeeInfoCellView *cellView = (MShopEmployeeInfoCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    MShopEmployeeInfo *employeeInfo = (MShopEmployeeInfo *)[cellInfo getUserInfoValueForKey:@"MShopEmployeeInfo"];
    [cellView setEmployeeInfo:employeeInfo];
}

-(void)onClickEmployeeInfoCell:(MFTableViewCellInfo *)cellInfo
{
    if ([self.m_delegate respondsToSelector:@selector(onDidSelectEmployee:)])
    {
        MShopEmployeeInfo *employeeInfo = (MShopEmployeeInfo *)[cellInfo getUserInfoValueForKey:@"MShopEmployeeInfo"];
        [self.m_delegate onDidSelectEmployee:employeeInfo];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
