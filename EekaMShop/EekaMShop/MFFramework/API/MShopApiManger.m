//
//  MShopApiManger.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopApiManger.h"

#define MFURL [MShopApiManger hostUrl]

#define MFURLWithPara(para) [MFURL stringByAppendingPathComponent:para]

NSString *const MShopApiUrl = @"http://mp.eekamclub.com/ms/";
NSString *const MShopApiTestUrl = @"http://120.76.242.182:8083/ms/";

@implementation MShopApiManger

+ (NSString *)hostUrl
{
    return MShopApiTestUrl;
//    return @"http://10.8.143.30:8080/ms/";   //zao long
//    return @"http://10.8.143.193:8080/ms/"; //guo dong
}

+(NSString *)loginURL
{
    return MFURLWithPara(@"employeeApi/qywxLogin.json");
}

+(NSString *)userLoginURL
{
    return MFURLWithPara(@"employeeApi/userLogin.json");
}

+(NSString *)getEmployeeListURL
{
    return MFURLWithPara(@"employeeApi/getEmployeeList.json");
}

+(NSString *)getIndividualURL
{
    return MFURLWithPara(@"employeeApi/getIndividual.json");
}

+(NSString *)searchIndividualURL
{
    return MFURLWithPara(@"employeeApi/searchIndividual.json");
}

+(NSString *)individualConsumptionURL
{
    return MFURLWithPara(@"employeeApi/individualConsumption.json");
}

+(NSString *)getIndividualListURL
{
    return MFURLWithPara(@"employeeApi/getIndividualList.json");
}

+(NSString *)individualModifyURL
{
    return MFURLWithPara(@"employeeApi/individualModify.json");
}

+(NSString *)getConsumptionItemsURL
{
    return MFURLWithPara(@"employeeApi/getConsumptionItems.json");
}

+(NSString *)getAppointmentListURL
{
    return MFURLWithPara(@"employeeApi/getAppointmentList.json");
}

+(NSString *)appointmentModifyURL
{
    return MFURLWithPara(@"employeeApi/appointmentModify.json");
}

+(NSString *)checkIndividualPointURL
{
    return MFURLWithPara(@"employeeApi/checkIndividualPoint.json");
}

+(NSString *)sendVerificationCodeURL
{
    return MFURLWithPara(@"employeeApi/sendVerificationCode.json");
}

+(NSString *)getSynMemberInfoURL
{
    return MFURLWithPara(@"employeeApi/getInfoByExcel.json");
}

+(NSString *)getFrozenEmployeeListURL
{
    return MFURLWithPara(@"employeeApi/getFrozenEmployeeList.json");
}

+(NSString *)frozenOptEmployeeURL
{
    return MFURLWithPara(@"employeeApi/frozenOptEmployee.json");
}

@end
