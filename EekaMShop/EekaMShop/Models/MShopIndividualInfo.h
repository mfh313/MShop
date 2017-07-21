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
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *occupationType;
@property (nonatomic,strong) NSString *maintainDeptId;
@property (nonatomic,strong) NSString *maintainEmployeeId;
@property (nonatomic,assign) NSUInteger beginCount;
@property (nonatomic,assign) NSUInteger endCount;

@end
