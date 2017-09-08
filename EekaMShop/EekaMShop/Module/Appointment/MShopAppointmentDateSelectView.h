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
-(void)didSetAppointmentDate:(NSString *)appointmentDate appointmentTime:(NSString *)appointmentTime selectView:(MShopAppointmentDateSelectView *)selectView;

@end

@class MShopAppointmentDataItem;
@interface MShopAppointmentDateSelectView : MMUIBridgeView

@property (nonatomic,weak) id<MShopAppointmentDateSelectViewDelegate> m_delegate;

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem;

@end
