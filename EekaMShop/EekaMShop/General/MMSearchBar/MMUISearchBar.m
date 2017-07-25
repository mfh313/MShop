//
//  MMUISearchBar.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUISearchBar.h"

@implementation MMUISearchBar

//UISearchBarTextField
//UISearchBarBackground
//UINavigationButton

- (id)findUISearchBarBackground:(id)arg1
{
    for (UIView *subview in [[self.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            return subview;
        }
    }
    
    return nil;
}

- (id)findCancelButton
{
    for (UIView *subview in [[self.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            return subview;
        }
    }
    
    return nil;
}

@end
