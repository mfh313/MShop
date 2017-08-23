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

NSString const *MShopApiTestUrl = @"https://pos.koradior.info:8443/";
NSString const *MShopApiUrl = @"https://pos.szyingjia.cn:8888/";

@implementation MShopApiManger

+ (NSString *)hostUrl
{
    return @"http://mp.eekamclub.com/ms/";
//    return @"http://10.8.143.30:8080/ms/";   //zaolong
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

+(NSString *)getSynMemberInfoURL
{
    return MFURLWithPara(@"employeeApi/getInfoByExcel.json");
}

+(NSString *)pushMessageURL
{
    //message
    //alias
    //http://mp.eekamclub.com/ms/employeeApi/pushMessage.json?message=ssadasdasdsa
    return MFURLWithPara(@"employeeApi/pushMessage.json");
}

@end
