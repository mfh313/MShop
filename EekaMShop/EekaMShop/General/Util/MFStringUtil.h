//
//  MFStringUtil.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const MFPhoneNumberRegex = @"1[3|4|5|7|8][0-9]\\d{8}$";

@interface MFStringUtil : NSObject

+(BOOL)isBlankString:(NSString *)string;

+(BOOL)isPhoneString:(NSString *)string;

+(NSString *)floatStringWithTwoPoint:(CGFloat)aFloat;

+(NSString *)floatStringWithFourPoint:(CGFloat)aFloat;

+(NSString *)URLEncodedString:(NSString *)str;

+(NSString *)URLDecodedString:(NSString *)str;

+(NSString *)moneyDescWithNumber:(NSNumber *)money;

+(NSDate *)dateWithTimeString:(NSString *)dateStr;

+(NSString *)dateWithMMString:(NSString *)dateStr;

+(NSString *)dateWithMMddString:(NSString *)dateStr;

@end
