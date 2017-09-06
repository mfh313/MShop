//
//  MShopAppointmentModifyApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentModifyApi.h"
#import "MShopAppointmentDataItem.h"

@implementation MShopAppointmentModifyApi

-(NSString *)requestUrl
{
    return [MShopApiManger appointmentModifyURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    NSDictionary *modelJSON = [self.dataItem MMmodelToJSONObject];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelJSON
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return @{
             @"appointmentStr":jsonString
             };
}

@end
