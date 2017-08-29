//
//  MShopFrozenOptEmployeeApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

extern NSString *const MShopFrozenStatusOpen;
extern NSString *const MShopFrozenStatusClose;

@interface MShopFrozenOptEmployeeApi : MFNetworkRequest

@property (nonatomic,strong) NSString *employeeId;
@property (nonatomic,strong) NSString *employeeName;
@property (nonatomic,strong) NSString *status;

@end
