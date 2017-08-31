//
//  MShopFrozenEmployeeCellView.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class MShopFrozenEmployeeModel;
@protocol MShopFrozenEmployeeCellViewDelegate <NSObject>

@optional
-(void)onClickFrozenEmployee:(MShopFrozenEmployeeModel *)employeeInfo;

@end


@interface MShopFrozenEmployeeCellView : MMUIBridgeView

@property (nonatomic,weak) id<MShopFrozenEmployeeCellViewDelegate> m_delegate;

-(void)setEmployeeInfo:(MShopFrozenEmployeeModel *)employeeInfo;

@end
