//
//  MShopMemberListCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberListCellView.h"
#import "MShopIndividualInfo.h"

@interface MShopMemberListCellView ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    __weak IBOutlet UILabel *_maintainEmployeeLabel;
}

@end

@implementation MShopMemberListCellView

-(void)setIndividualInfo:(MShopIndividualInfo *)info
{
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:MFImage(@"avtar")];
    _nameLabel.text = info.individualName;
    _phoneLabel.text = info.phone;
    
    if ([info hasMaintainEmployee]) {
        _maintainEmployeeLabel.text = [NSString stringWithFormat:@"维护员工:%@",info.maintainEmployeeName];
    }
    else
    {
        _maintainEmployeeLabel.text = [NSString stringWithFormat:@"未分配维护员工"];
    }
}

@end
