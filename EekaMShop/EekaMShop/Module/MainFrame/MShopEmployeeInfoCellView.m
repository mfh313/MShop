//
//  MShopEmployeeInfoCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopEmployeeInfoCellView.h"
#import "MShopEmployeeInfo.h"

@interface MShopEmployeeInfoCellView ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
}

@end

@implementation MShopEmployeeInfoCellView

-(void)setEmployeeInfo:(MShopEmployeeInfo *)employeeInfo
{
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:employeeInfo.avatar] placeholderImage:MFImage(@"avtar")];
    _nameLabel.text = employeeInfo.name;
}

@end