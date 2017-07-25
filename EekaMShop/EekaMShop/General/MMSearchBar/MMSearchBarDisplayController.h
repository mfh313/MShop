//
//  MMSearchBarDisplayController.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"

@interface MMSearchBarDisplayController : MMViewController <UISearchDisplayDelegate,UISearchBarDelegate>
{
    UISearchBar *m_searchBar;
    UISearchDisplayController *m_searchDisplayController;
    BOOL m_isActive;
}

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;

-(void)SearchBarBecomeUnActive;
-(void)didAppear;
-(BOOL)isSeachActive;
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
-(void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView;
-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView;
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView;
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption;
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
-(void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView;
-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView;
-(void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView;
-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller;
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller;
-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller;

@end
