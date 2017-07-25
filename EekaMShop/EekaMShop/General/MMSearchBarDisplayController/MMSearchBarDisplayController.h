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
}

@end
