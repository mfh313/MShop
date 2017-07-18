//
//  MMOnePixLayoutConstraint.m
//  YJCustom
//
//  Created by EEKA on 2016/10/19.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMOnePixLayoutConstraint.h"

@implementation MMOnePixLayoutConstraint

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.constant = MFOnePixHeight;
}

@end


#pragma mark - MMOnePixLine
@implementation MMOnePixLine

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.constraints.count > 0) {
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.constant == 1) {
                constraint.constant = MFOnePixHeight;
            }
        }
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [MFCustomLineColor setFill];
    UIRectFill(rect);
}

@end
