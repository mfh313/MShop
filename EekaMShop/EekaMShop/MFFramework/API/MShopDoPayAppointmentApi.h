//
//  MShopDoPayAppointmentApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/9/6.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopDoPayAppointmentApi : MFNetworkRequest

@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,strong) NSString *type;

-(NSString *)verificationCode;

@end


