//
//  MMSearchBar.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMSearchBar;

@protocol MMSearchBarDelegate <NSObject>

@optional
- (void)SearchBarBecomeActive;
- (void)SearchBarBecomeUnActive;
- (void)SearchBarShouldEnd;
- (void)cancelSearch;
- (UITableViewCell *)cellForIndex:(NSIndexPath *)indexPath ForSearchViewTable:(UITableView *)tableView;
- (UITableViewCell *)cellForSearchViewTable:(UITableViewCell *)cell index:(NSIndexPath *)indexPath;
- (void)didScrollViewBeginDragging:(UIScrollView *)scrollView;
- (void)didScrollViewScroll:(UIScrollView *)scrollView;
- (void)didSearchViewTableSelect:(NSIndexPath *)indexPath;
- (void)doSearch:(NSString *)searchText Pre:(BOOL)pre;
- (double)heightForHeaderInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView;
- (double)heightForSearchViewTable:(NSIndexPath *)indexPath;
- (void)mmSearchBarDidEnd;
- (void)mmSearchBarTextDidChange:(NSString *)searchText;
- (void)mmSearchDisplayControllerDidBeginSearch;
- (void)mmSearchDisplayControllerDidEndSearch;
- (void)mmSearchDisplayControllerDidHideSearchResultsTableView:(UITableView *)tableView;
- (void)mmSearchDisplayControllerDidShowSearchResultsTableView:(UITableView *)tableView;
- (void)mmSearchDisplayControllerWillBeginSearch;
- (void)mmSearchDisplayControllerWillEndSearch;
- (void)mmSearchDisplayControllerWillHideSearchResultsTableView:(UITableView *)tableView;
- (void)mmSearchDisplayControllerWillShowSearchResultsTableView:(UITableView *)tableView;
- (void)mmsearchBarCancelButtonClicked:(MMSearchBar *)searchBar;
- (void)mmsearchBarSearchButtonClicked:(MMSearchBar *)searchBar;
- (BOOL)mmsearchBarShouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)mmsearchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (NSInteger)numberOfRowsInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView;
- (NSInteger)numberOfSectionsForSearchViewTable:(UITableView *)tableView;
- (BOOL)shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldShowTabbarAfterSearchBarBecomeUnActive;
- (NSString *)titleForHeaderInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView;
- (UIView *)viewForHeaderInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView;
@end

@interface MMSearchBar : NSObject <UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    
}


@end
