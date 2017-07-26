//
//  MShopMemberSearchBar.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberSearchBar.h"

@implementation MShopMemberSearchBar

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [super searchDisplayControllerDidBeginSearch:controller];
    
    if (!_searchGuideView) {
        _searchGuideView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchGuideView.backgroundColor = [UIColor redColor];
    }
    
    _searchGuideView.frame = CGRectMake(0, 64, CGRectGetWidth(controller.searchContentsController.view.frame), CGRectGetHeight(controller.searchContentsController.view.frame) - 64);
    [controller.searchContentsController.view addSubview:_searchGuideView];
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [super searchDisplayControllerWillEndSearch:controller];
    
    [_searchGuideView removeFromSuperview];
}

@end
