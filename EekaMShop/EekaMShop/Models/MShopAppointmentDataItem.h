//
//  MShopAppointmentDataItem.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MShopAppointmentStatusPending;
extern NSString *const MShopAppointmentStatusHandled;
extern NSString *const MShopAppointmentStatusInvalidate;

@interface MShopAppointmentDataItem : NSObject

@property (nonatomic,strong) NSNumber *appointmentId;
@property (nonatomic,strong) NSString *appointmentNo;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,strong) NSString *individualName;
@property (nonatomic,strong) NSString *individualPhone;
@property (nonatomic,strong) NSString *appointmentDate;
@property (nonatomic,strong) NSString *appointmentTime;
@property (nonatomic,strong) NSString *deptId;
@property (nonatomic,strong) NSString *deptName;
@property (nonatomic,strong) NSString *employeeId;
@property (nonatomic,strong) NSString *employeeName;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSString *createdtime;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *evaluate;

@end
