//
//  MFStringUtil.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFStringUtil.h"

@implementation MFStringUtil

+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(BOOL)isPhoneString:(NSString *)string
{
    return YES;
}

+(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

+(NSString *)floatStringWithTwoPoint:(CGFloat)aFloat
{
    return [NSString stringWithFormat:@"%.2f",aFloat];
}

+(NSString *)floatStringWithFourPoint:(CGFloat)aFloat
{
    return [NSString stringWithFormat:@"%.4f",aFloat];
}

+(NSString *)moneyDescWithNumber:(NSNumber *)money
{
    return [NSString stringWithFormat:@"¥ %.2f ",money.floatValue];
}

+(NSTimeZone *)timeZone
{
    return [NSTimeZone timeZoneWithName:@"GMT"];
}

+(NSDate *)dateWithTimeString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[[self class] timeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    if (date == nil) {
        NSString *defaultDateString = [formatter stringFromDate:[NSDate date]];
        date = [formatter dateFromString:defaultDateString];
    }
    
    return date;
}

+(NSString *)dateWithMMddString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[[self class] timeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *dateString = nil;
    
    [formatter setDateFormat:@"MMdd"];
    if (date == nil)
    {
        dateString = [formatter stringFromDate:[NSDate date]];
    }
    else
    {
        dateString = [formatter stringFromDate:date];
    }
    
    return dateString;
}

+(NSString *)dateWithMMString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[[self class] timeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *dateString = nil;
    
    [formatter setDateFormat:@"MM"];
    if (date == nil)
    {
        dateString = [formatter stringFromDate:[NSDate date]];
    }
    else
    {
        dateString = [formatter stringFromDate:date];
    }
    
    return dateString;
}

@end
