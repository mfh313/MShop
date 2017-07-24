//
//  MShopIndividualModifyApi.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopIndividualModifyApi.h"
#import "MShopIndividualInfo.h"

@implementation MShopIndividualModifyApi

-(NSString *)requestUrl
{
    return [MShopApiManger individualModifyURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgumentWithToken
{
    NSDictionary *modelJSON = [self.individualInfo MMmodelToJSONObject];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelJSON
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return @{
             @"individualStr":jsonString
             };
}

@end
