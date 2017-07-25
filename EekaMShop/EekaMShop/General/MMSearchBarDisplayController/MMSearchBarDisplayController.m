//
//  MMSearchBarDisplayController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMSearchBarDisplayController.h"

@interface MMSearchBarDisplayController ()

@end

@implementation MMSearchBarDisplayController
@synthesize searchBar = m_searchBar;
@synthesize searchDisplayController = m_searchDisplayController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)SearchBarBecomeUnActive
{
    m_isActive = NO;
}

- (void)didAppear
{
    m_isActive = YES;
}

- (BOOL)isSeachActive
{
    return m_isActive;
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView
{
    
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    
}

-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
