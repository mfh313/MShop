//
//  MShopMemberSearchBar.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberSearchBar.h"

@implementation MShopMemberSearchBar

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
NS_DEPRECATED_IOS(3_0,8_0)
{
    [super searchDisplayControllerWillBeginSearch:controller];
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
NS_DEPRECATED_IOS(3_0,8_0)
{
    [super searchDisplayControllerDidBeginSearch:controller];
    
    if (!_searchGuideView) {
        _searchGuideView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchGuideView.backgroundColor = [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.contentSize = CGSizeZero;
        _scrollView.delegate = self;
        
        _whiteLayerView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _searchTipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _searchTipLabel.textAlignment = NSTextAlignmentCenter;
        _searchTipLabel.text = @"输入会员完整姓名或者手机号\n1、手机号支持模糊搜索,手机号码至少四位，比如8953,8460。。。\n2、手机号码输入小于4位不会查询会员。";
        _searchTipLabel.numberOfLines = 0;
        _searchTipLabel.font = [UIFont systemFontOfSize:16.0f];
        _searchTipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_whiteLayerView addSubview:_searchTipLabel];
        [_scrollView addSubview:_whiteLayerView];
        
        [_searchGuideView addSubview:_scrollView];
    }
    
    UIView *searchDisplayControllerContainerView = controller.searchContentsController.view;
    
    _searchGuideView.frame = CGRectMake(0, 64, CGRectGetWidth(searchDisplayControllerContainerView.frame), CGRectGetHeight(searchDisplayControllerContainerView.frame));
    _scrollView.frame = _searchGuideView.bounds;
    _scrollView.contentSize = CGSizeZero;
    _whiteLayerView.frame = _searchGuideView.bounds;
    _searchTipLabel.frame = CGRectMake(20, 20, CGRectGetWidth(_searchGuideView.frame) - 40, 120);
    [searchDisplayControllerContainerView addSubview:_searchGuideView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGuideView)];
    [_searchGuideView addGestureRecognizer:tapGes];
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
NS_DEPRECATED_IOS(3_0,8_0)
{
    [super searchDisplayControllerWillEndSearch:controller];
    
    [_searchGuideView removeFromSuperview];
}

-(void)hideSearchGuideView
{
    [_searchGuideView removeFromSuperview];
}

-(void)onTapGuideView
{
    [self.m_searchBar resignFirstResponder];
}


@end
