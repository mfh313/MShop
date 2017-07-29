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

@interface MShopMemberConsumptionViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
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
    
    [self getConsumptionItems];
}

-(void)getConsumptionItems
{
    __weak typeof(self) weakSelf = self;
    
    MShopGetConsumptionItemsApi *mfApi = [MShopGetConsumptionItemsApi new];
    mfApi.animatingText = @"正在获取消费信息...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
//        [_individualArray removeAllObjects];
//        
//        NSArray *individualList = request.responseObject[@"individualList"];
//        for (int i = 0; i < individualList.count; i++) {
//            MShopIndividualInfo *individual = [MShopIndividualInfo MM_modelWithJSON:individualList[i]];
//            [_individualArray addObject:individual];
//        }
        
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
    
//    if (_individualArray.count == 0) {
//        [self addBlankView];
//        return;
//    }
//    
//    MFTableViewSectionInfo *sectionInfo = [self addMemberSection];
//    [m_tableViewInfo addSection:sectionInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
