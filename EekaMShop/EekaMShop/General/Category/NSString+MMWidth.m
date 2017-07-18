//
//  NSString+MMWidth.m
//  YJCustom
//
//  Created by EEKA on 16/9/22.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "NSString+MMWidth.h"

@implementation NSString (MMWidth)

-(CGSize)MMSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{    
    CGSize textBlockMinSize = maxSize;
    
    CGSize size = CGSizeZero;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine
    | NSStringDrawingUsesLineFragmentOrigin
    | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle
                                                alloc] init];
    
    [paragraphStyle setLineSpacing:1];//调整行间距
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
    
    size = [self boundingRectWithSize:textBlockMinSize
                                options:options
                             attributes:attributes
                                context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

@end
