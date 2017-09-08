//
//  MShopAppointmentDateSelectView.h
//  EekaMShop
//
//  Created by EEKA on 2017/9/8.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class MShopAppointmentDateSelectView;
@protocol MShopAppointmentDateSelectViewDelegate <NSObject>

@optional
-(void)onClickDoneButton:(MShopAppointmentDateSelectView *)selectView;

@end

@interface MShopAppointmentDateSelectView : MMUIBridgeView

@property (nonatomic,weak) id<MShopAppointmentDateSelectViewDelegate> m_delegate;

@end
