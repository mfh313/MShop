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

@interface MShopMemberDetailViewController ()
{
    MFTableViewInfo *m_tableViewInfo;
}

@end

@implementation MShopMemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员资料";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    CGRect tableFrame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentTableView];
    
    [self addMemberSection];
}

- (void)addMemberSection
{
    [self makeProfileCell];
    
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeMemberListCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickMemberListCell:)
                                                           actionTarget:self
                                                                 height:100.0f
                                                               userInfo:nil];
    cellInfo.selectionStyle = UITableViewCellSelectionStyleGray;
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)makeProfileCell
{
//    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
//    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:<#(SEL)#> makeTarget:<#(id)#> height:<#(CGFloat)#> userInfo:<#(MFTableViewUserInfo *)#>];
//    [sectionInfo addCell:cellInfo];
//    
//    [m_tableViewInfo addSection:sectionInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
