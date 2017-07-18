//
//  MFTableViewInfo.h
//  EekaPOS
//
//  Created by EEKA on 2017/7/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewUserInfo.h"
#import "MFUITableView.h"
#import "MFTableViewCellInfo.h"
#import "MFTableViewSectionInfo.h"


@protocol MFTableViewInfoDelegate <NSObject, UIScrollViewDelegate, tableViewDelegate>

@optional
- (void)commitEditingForRowAtIndexPath:(NSIndexPath *)indexPath cell:(MFTableViewCellInfo *)cellInfo;
- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath cell:(MFTableViewCellInfo *)cellInfo;

@end

@interface MFTableViewInfo : MFTableViewUserInfo <UITableViewDataSource,UITableViewDelegate,tableViewDelegate>
{
    MFUITableView *_tableView;
    NSMutableArray<MFTableViewSectionInfo *> *_arrSections;
    __weak id<MFTableViewInfoDelegate> _delegate;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (MFTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row;

@end
