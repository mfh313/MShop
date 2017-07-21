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
    return @"http://ad.koradior.info/ms/";
}

+(NSString *)loginURL
{
    return MFURLWithPara(@"employeeApi/qywxLogin.json");
}

+(NSString *)getEmployeeListURL
{
    return MFURLWithPara(@"employeeApi/getEmployeeList.json");
}

+(NSString *)getIndividualList
{
    return MFURLWithPara(@"employeeApi/getIndividualList.json");
}

@end
