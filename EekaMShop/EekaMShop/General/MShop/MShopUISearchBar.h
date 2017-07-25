//
//  MShopUISearchBar.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MShopUISearchBar : UISearchBar

- (id)findCancelButton;
- (id)findPlaceHolderIcon:(id)arg1;
- (id)findUISearchBarBackground:(id)arg1;
- (id)findUISearchBarImage:(id)arg1;
- (id)findUISearchBarTextFieldLabel:(id)arg1;
- (void)fixOrientationBug;
- (void)fixSearchIconSize;
- (id)getNavigationButton:(id)arg1;
- (id)init;
@property(nonatomic) _Bool m_bForceAdjustFrame; // @synthesize m_bForceAdjustFrame;
- (void)setFrame:(struct CGRect)arg1;

@end
