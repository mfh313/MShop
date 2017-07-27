//
//  MShopEmployeeInfo.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopEmployeeInfo.h"

@implementation MShopEmployeeInfo

-(BOOL)isShopKeeper
{
    if ([self.position isEqualToString:@"店长"])
    {
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
