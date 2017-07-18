//
//  UIView+viewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/28.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "UIView+viewController.h"

@implementation UIView (viewController)

- (UIViewController *)MFViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UITableView *)MFTableView {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView *)nextResponder;
        }
    }
    return nil;
}

@end
