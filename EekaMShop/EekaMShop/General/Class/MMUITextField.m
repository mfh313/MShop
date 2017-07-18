//
//  MMUITextField.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUITextField.h"

@implementation MMUITextField
@synthesize m_bRestrictShareMenu,m_fPlaceholderFontSize;
    
-(instancetype)init
{
    self = [super init];
    if (self) {
        m_fPlaceholderFontSize = 16.0;
    }
    
    return self;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.m_bRestrictShareMenu) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}
    
-(void)drawPlaceholderInRect:(CGRect)rect
{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSFontAttributeName : [UIFont italicSystemFontOfSize:m_fPlaceholderFontSize]
                                 };
    // center vertically
    CGSize textSize = [self.placeholder sizeWithAttributes:attributes];
    CGFloat hdif = rect.size.height - textSize.height;
    hdif = MAX(0, hdif);
    rect.origin.y += ceil(hdif/2.0);
    [[self placeholder] drawInRect:rect withAttributes:attributes];
    
//    UIColor *placeholderColor = [UIColor redColor];//设置颜色
//    [placeholderColor setFill];
//    
//    
//    CGRect placeholderRect = CGRectMake(rect.origin.x+10, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);//设置距离
//    
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.lineBreakMode = NSLineBreakByTruncatingTail;
//    style.alignment = self.textAlignment;
//    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
//    
//    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

@end
