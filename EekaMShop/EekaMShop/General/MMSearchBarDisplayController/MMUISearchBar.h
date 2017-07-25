//
//  MMUISearchBar.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMUISearchBar : UISearchBar
{
    BOOL m_bForceAdjustFrame;
}

@property (nonatomic,assign) BOOL m_bForceAdjustFrame;

- (id)findCancelButton;
- (id)findPlaceHolderIcon:(id)arg1;
- (id)findUISearchBarBackground:(id)arg1;
- (id)findUISearchBarImage:(id)arg1;
- (id)findUISearchBarTextFieldLabel:(id)arg1;
- (void)fixOrientationBug;
- (void)fixSearchIconSize;
- (id)getNavigationButton:(id)arg1;
- (id)init;

@end
