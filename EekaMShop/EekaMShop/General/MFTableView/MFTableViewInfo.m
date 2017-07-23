//
//  MFTableViewInfo.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewInfo.h"

#define NoWarningPerformSelector(target, action, object, object1) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object withObject:object1] \
_Pragma("clang diagnostic pop") \

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
    if (!cell) {
        cell = [[MFTableViewCell alloc] initWithStyle:cellInfo.cellStyle reuseIdentifier:identifier];
        cell.selectionStyle = cellInfo.selectionStyle;
    }
    else
    {
        [cell.contentView removeAllSubViews];
    }
    
    if (cellInfo.makeTarget) {
        if ([cellInfo.makeTarget respondsToSelector:cellInfo.makeSel]) {
            NoWarningPerformSelector(cellInfo.makeTarget, cellInfo.makeSel, cell, cellInfo);
        }
        if (cellInfo.bNeedSeperateLine && tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
            if (indexPath.row == 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0.5f)];
                line.backgroundColor = [UIColor grayColor];
                [cell.contentView addSubview:line];
            }
        }
        cellInfo.cell = cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        if (indexPath.row < [_arrSections[indexPath.section] getCellCount]) {
            MFTableViewCellInfo *cellInfo = [_arrSections[indexPath.section] getCellAt:indexPath.row];
            id target = cellInfo.calHeightTarget;
            if (target && [target respondsToSelector:cellInfo.calHeightSel]) {
                NoWarningPerformSelector(target, cellInfo.calHeightSel, cellInfo, nil);
            }
            return cellInfo.fCellHeight;
        }
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        MFTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            id target = cellInfo.actionTarget;
            if (target) {
                if ([target respondsToSelector:cellInfo.actionSel]) {
                    NoWarningPerformSelector(target, cellInfo.actionSel, cellInfo ,nil);
                }
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [_tableView reloadData];
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
