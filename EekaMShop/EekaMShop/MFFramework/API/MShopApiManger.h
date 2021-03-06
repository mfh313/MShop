//
//  MShopApiManger.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

extern NSString *const MShopApiUrl;
extern NSString *const MShopApiTestUrl;

@interface MShopApiManger : MMService

+(NSString *)loginURL;

+(NSString *)userLoginURL;

+(NSString *)getEmployeeListURL;

+(NSString *)getIndividualListURL;

+(NSString *)searchIndividualURL;

+(NSString *)getIndividualURL;

+(NSString *)individualConsumptionURL;

+(NSString *)individualModifyURL;

+(NSString *)getConsumptionItemsURL;

+(NSString *)getAppointmentListURL;

+(NSString *)checkIndividualPointURL;

+(NSString *)appointmentModifyURL;

+(NSString *)sendVerificationCodeURL;

+(NSString *)getSynMemberInfoURL;

+(NSString *)getFrozenEmployeeListURL;

+(NSString *)frozenOptEmployeeURL;

@end
