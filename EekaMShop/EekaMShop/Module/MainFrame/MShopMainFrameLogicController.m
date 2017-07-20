//
//  MShopMainFrameLogicController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMainFrameLogicController.h"

@implementation MShopMainFrameCellData

+(instancetype)objectWithTitle:(NSString *)title
                        target:(id)target
                        action:(SEL)action
{
    MShopMainFrameCellData *object = [MShopMainFrameCellData new];
    
    object.title = title;
    object.target = target;
    object.action = action;
    
    return object;
}

@end

#pragma mark - MShopMainFrameLogicController
@implementation MShopMainFrameLogicController


@end
