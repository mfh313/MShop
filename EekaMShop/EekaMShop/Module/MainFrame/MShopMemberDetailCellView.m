//
//  MShopMemberDetailCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/27.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberDetailCellView.h"

@interface MShopMemberDetailCellView ()
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_rightValueLabel;
}

@end

@implementation MShopMemberDetailCellView

-(void)setTitle:(NSString *)title rightValue:(NSString *)rightValue
{
    _titleLabel.text = title;
    _rightValueLabel.text = rightValue;
}

@end
