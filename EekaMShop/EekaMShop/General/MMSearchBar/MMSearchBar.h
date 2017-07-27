//
//  MMSearchBar.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMUISearchBar.h"

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
- (CGFloat)heightForHeaderInSection:(NSInteger)section ForSearchViewTable:(UITableView *)tableView;
- (CGFloat)heightForSearchViewTable:(NSIndexPath *)indexPath;
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

@class MMUISearchBar,MMViewController;
@interface MMSearchBar : NSObject <UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    __weak id<MMSearchBarDelegate> m_delegate;
    NSString *m_nsLastSearchText;
    MMUISearchBar *m_searchBar;
    NSMutableArray *m_arrFilteredObject;
    UISearchDisplayController *m_searchDisplayController;
    MMViewController *m_viewController;
    NSInteger m_returnKeyType;
    BOOL m_isShouldRemoveDimmingView;
}

@property (nonatomic,weak) id<MMSearchBarDelegate> m_delegate;
@property (nonatomic,strong) NSString *m_nsLastSearchText;
@property (nonatomic,assign) NSInteger m_returnKeyType;
@property (nonatomic,strong) MMUISearchBar *m_searchBar;
@property (nonatomic,strong) UISearchDisplayController *m_searchDisplayController;

- (id)initWithContentsController:(MMViewController *)viewController;
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller;
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller;
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller;

- (UIView *)findDimmingView;

@end
