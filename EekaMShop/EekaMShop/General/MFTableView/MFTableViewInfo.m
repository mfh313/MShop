//
//  MFTableViewInfo.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewInfo.h"

@implementation MFTableViewInfo

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableView = [[MFUITableView alloc] initWithFrame:frame style:style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.m_delegate = self;
        _arrSections = @[].mutableCopy;
    }
    return self;
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrSections[section] getCellCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"MFTableViewInfo_%zd_%f", cellInfo.cellStyle, cellInfo.fCellHeight];
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

- (MFTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row
{
    if (_arrSections.count >= section && [_arrSections[section] getCellCount] >= row) {
        return [_arrSections[section] getCellAt:row];
    } else {
        return nil;
    }
}

- (UITableView *)getTableView
{
    return _tableView;
}

#pragma mark - Section
- (void)addSection:(MFTableViewSectionInfo *)section
{
    [_arrSections safeAddObject:section];
}

- (void)clearAllSection
{
    [_arrSections removeAllObjects];
}

- (void)removeSectionAt:(NSUInteger)section
{
    if (_arrSections.count < section) {
        return;
    }
    [_arrSections removeObjectAtIndex:section];
    [_tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSUInteger)getSectionCount
{
    return _arrSections.count;
}

- (MFTableViewSectionInfo *)getSectionAt:(NSUInteger)section
{
    if (section < _arrSections.count) {
        return _arrSections[section];
    }
    return nil;
}

@end
