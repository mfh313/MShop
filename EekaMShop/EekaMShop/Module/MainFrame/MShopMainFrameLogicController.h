//
//  MShopMainFrameLogicController.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MShopMainFrameCellData : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) id target;
@property (nonatomic,assign) SEL action;

+(instancetype)objectWithTitle:(NSString *)title
                        target:(id)target
                        action:(SEL)action;

@end

#pragma mark - MShopMainFrameLogicController
@interface MShopMainFrameLogicController : NSObject

@end
