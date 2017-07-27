//
//  MShopMemberSearchBar.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/26.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMSearchBar.h"

@interface MShopMemberSearchBar : MMSearchBar
{
    UIView *_searchGuideView;
    UIScrollView *_scrollView;
    UIView *_whiteLayerView;
    UILabel *_searchTipLabel;
}

-(void)hideSearchGuideView;

@end
