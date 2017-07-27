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
{
    [super searchDisplayControllerWillBeginSearch:controller];
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
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
        _searchTipLabel.text = @"输入会员姓名或者手机号\n手机号支持模糊搜索,尽量输入数字长度大于3，比如135，137。。。";
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
    _searchTipLabel.frame = CGRectMake(20, 20, CGRectGetWidth(_searchGuideView.frame) - 40, 60);
    [searchDisplayControllerContainerView addSubview:_searchGuideView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGuideView)];
    [_searchGuideView addGestureRecognizer:tapGes];
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [super searchDisplayControllerWillEndSearch:controller];
    
    [_searchGuideView removeFromSuperview];
}

-(void)onTapGuideView
{
    [self.m_searchBar resignFirstResponder];
}


@end
