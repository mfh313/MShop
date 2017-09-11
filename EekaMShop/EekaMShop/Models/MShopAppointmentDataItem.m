//
//  MShopAppointmentDataItem.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentDataItem.h"

NSString *const MShopAppointmentStatusPending = @"0";  //待处理
NSString *const MShopAppointmentStatusHandled = @"1";  //已处理
NSString *const MShopAppointmentStatusInvalidate = @"2"; //作废
NSString *const MShopAppointmentStatusConfirmed = @"3";  //已确认

@implementation MShopAppointmentDataItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"appointmentId" : @"id"
             };
}

@end
