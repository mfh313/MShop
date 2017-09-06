//
//  MShopIndividualInfo.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MShopIndividualInfo : NSObject

@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *openId;
@property (nonatomic,strong) NSString *individualNo;
@property (nonatomic,strong) NSString *individualName;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *yob;
@property (nonatomic,strong) NSString *mob;
@property (nonatomic,strong) NSString *dob;
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *occupationType;
@property (nonatomic,strong) NSString *maintainDeptId;
@property (nonatomic,strong) NSString *maintainDeptName;
@property (nonatomic,strong) NSString *maintainEmployeeId;
@property (nonatomic,strong) NSString *maintainEmployeeName;
@property (nonatomic,assign) NSUInteger beginCount;
@property (nonatomic,assign) NSUInteger endCount;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,assign) NSUInteger currentPoint;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *provinceName;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *regionName;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,assign) BOOL birthdayFlag;
@property (nonatomic,assign) CGFloat balance;
@property (nonatomic,assign) NSUInteger couponCount;

-(BOOL)hasMaintainEmployee;

-(NSString *)genderDescribe;

@end
