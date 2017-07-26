//
//  MMSearchBar.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMSearchBar.h"

@implementation MMSearchBar
@synthesize m_searchBar,m_returnKeyType,m_nsLastSearchText,m_delegate,m_searchDisplayController;

- (id)initWithContentsController:(MMViewController *)viewController
{
    if (self) {
        
        m_returnKeyType = UIReturnKeySearch;
        
        m_searchBar = [[MMUISearchBar alloc] init];
        m_searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(viewController.view.frame), 44);
        m_searchBar.placeholder = @"搜索";
        m_searchBar.tintColor = [UIColor hx_colorWithHexString:@"0080C0"];
        m_searchBar.delegate = self;
        m_searchBar.returnKeyType = m_returnKeyType;
        
        m_viewController = viewController;
        
        m_searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:m_searchBar contentsController:viewController];
        m_searchDisplayController.searchResultsDataSource = self;
        m_searchDisplayController.searchResultsDelegate = self;
        m_searchDisplayController.delegate = self;
    }
    
    return self;
}

-(NSString *)m_nsLastSearchText
{
    return m_searchBar.text;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [m_searchDisplayController setActive:YES animated:YES];
    
    if ([self.m_delegate respondsToSelector:@selector(SearchBarBecomeActive)]) {
        [self.m_delegate SearchBarBecomeActive];
    }
    
    if ([self.m_delegate respondsToSelector:@selector(mmsearchBarTextDidBeginEditing:)]) {
        [self.m_delegate mmsearchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    if ([self.m_delegate respondsToSelector:@selector(SearchBarShouldEnd)]) {
        [self.m_delegate SearchBarShouldEnd];
    }
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchBarDidEnd)]) {
        [self.m_delegate mmSearchBarDidEnd];
    }
    
    if ([self.m_delegate respondsToSelector:@selector(SearchBarBecomeUnActive)]) {
        [self.m_delegate SearchBarBecomeUnActive];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchBarTextDidChange:)]) {
        [self.m_delegate mmSearchBarTextDidChange:searchText];
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.m_delegate respondsToSelector:@selector(mmsearchBarShouldChangeTextInRange:replacementText:)]) {
        return [self.m_delegate mmsearchBarShouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.m_delegate respondsToSelector:@selector(mmsearchBarSearchButtonClicked:)]) {
        [self.m_delegate mmsearchBarSearchButtonClicked:self];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [m_searchDisplayController setActive:NO animated:YES];
    
    if ([self.m_delegate respondsToSelector:@selector(mmsearchBarCancelButtonClicked:)]) {
        [self.m_delegate mmsearchBarCancelButtonClicked:self];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}


#pragma amrk - UISearchDisplayDelegate
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerWillBeginSearch)]) {
        [self.m_delegate mmSearchDisplayControllerWillBeginSearch];
    }
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerDidBeginSearch)]) {
        [self.m_delegate mmSearchDisplayControllerDidBeginSearch];
    }
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerWillEndSearch)]) {
        [self.m_delegate mmSearchDisplayControllerWillEndSearch];
    }
}

-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerDidEndSearch)]) {
        [self.m_delegate mmSearchDisplayControllerDidEndSearch];
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerDidHideSearchResultsTableView:)]) {
        [self.m_delegate mmSearchDisplayControllerDidHideSearchResultsTableView:tableView];
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerDidShowSearchResultsTableView:)]) {
        [self.m_delegate mmSearchDisplayControllerDidShowSearchResultsTableView:tableView];
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerWillHideSearchResultsTableView:)]) {
        [self.m_delegate mmSearchDisplayControllerWillHideSearchResultsTableView:tableView];
    }
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    if ([self.m_delegate respondsToSelector:@selector(mmSearchDisplayControllerWillShowSearchResultsTableView:)]) {
        [self.m_delegate mmSearchDisplayControllerWillShowSearchResultsTableView:tableView];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.m_delegate respondsToSelector:@selector(numberOfSectionsForSearchViewTable:)])
    {
        return [self.m_delegate numberOfSectionsForSearchViewTable:tableView];
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.m_delegate respondsToSelector:@selector(numberOfRowsInSection:ForSearchViewTable:)])
    {
        return [self.m_delegate numberOfRowsInSection:section ForSearchViewTable:tableView];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.m_delegate respondsToSelector:@selector(cellForSearchViewTable:index:)]) {
        
        UITableViewCell *cell = [self.m_delegate cellForIndex:indexPath ForSearchViewTable:tableView];
        
        if ([self.m_delegate respondsToSelector:@selector(cellForSearchViewTable:index:)]) {
            cell = [self.m_delegate cellForSearchViewTable:cell index:indexPath];
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.m_delegate respondsToSelector:@selector(heightForSearchViewTable:)]) {
        return [self.m_delegate heightForSearchViewTable:indexPath];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.m_delegate respondsToSelector:@selector(heightForHeaderInSection:ForSearchViewTable:)]) {
        return [self.m_delegate heightForHeaderInSection:section ForSearchViewTable:tableView];
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.m_delegate respondsToSelector:@selector(viewForHeaderInSection:ForSearchViewTable:)]) {
        return [self.m_delegate viewForHeaderInSection:section ForSearchViewTable:tableView];
    }
    
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.m_delegate respondsToSelector:@selector(titleForHeaderInSection:ForSearchViewTable:)]) {
        return [self.m_delegate titleForHeaderInSection:section ForSearchViewTable:tableView];
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.m_delegate respondsToSelector:@selector(didSearchViewTableSelect:)]) {
        [self.m_delegate didSearchViewTableSelect:indexPath];
    }
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.m_delegate respondsToSelector:@selector(didScrollViewBeginDragging:)]) {
        [self.m_delegate didScrollViewBeginDragging:scrollView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.m_delegate respondsToSelector:@selector(didScrollViewScroll:)]) {
        [self.m_delegate didScrollViewScroll:scrollView];
    }
}

- (id)findDimmingView
{
    return nil;
}

@end
