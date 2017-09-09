//
//  MShopAppointmentCodeInputView.h
//  EekaMShop
//
//  Created by EEKA on 2017/9/9.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol MShopAppointmentCodeInputViewDelegate <NSObject>

@optional

-(void)onClickResendVerificationCode:(NSString *)phone;

@end

@class MShopAppointmentDataItem;
@interface MShopAppointmentCodeInputView : MMUIBridgeView

@property (nonatomic,weak) id<MShopAppointmentCodeInputViewDelegate> m_delegate;
@property (nonatomic, assign) NSInteger numberOfVertificationCode;

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem;

@end
