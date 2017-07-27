//
//  MShopIndividualInfo.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopIndividualInfo.h"

@implementation MShopIndividualInfo

-(BOOL)hasMaintainEmployee
{
    if (self.maintainEmployeeId
        && ![self.maintainEmployeeId isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

-(NSString *)genderDescribe
{
    if (self.gender.integerValue == 10) {
        return @"男";
    }
    else if (self.gender.integerValue == 20) {
        return @"女";
    }
    
    return @"无性别";
}

@end
