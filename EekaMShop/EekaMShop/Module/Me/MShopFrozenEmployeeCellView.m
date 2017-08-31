//
//  MShopFrozenEmployeeCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopFrozenEmployeeCellView.h"
#import "MShopFrozenEmployeeModel.h"

@interface MShopFrozenEmployeeCellView ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UIButton *_frozenButton;
    
    MShopFrozenEmployeeModel *m_employeeInfo;
}

@end

@implementation MShopFrozenEmployeeCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_frozenButton setBackgroundImage:MFImageStretchCenter(@"border_normal") forState:UIControlStateNormal];
}

-(void)setEmployeeInfo:(MShopFrozenEmployeeModel *)employeeInfo
{
    m_employeeInfo = employeeInfo;
    
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:m_employeeInfo.avatar] placeholderImage:MFImage(@"avtar")];
    _nameLabel.text = m_employeeInfo.name;
    
    if (m_employeeInfo.isFrozen) {
        [_frozenButton setTitle:@"解冻" forState:UIControlStateNormal];
    }
    else
    {
        [_frozenButton setTitle:@"冻结" forState:UIControlStateNormal];
    }
}

- (IBAction)onClickFrozenButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickFrozenEmployee:)]) {
        [self.m_delegate onClickFrozenEmployee:m_employeeInfo];
    }
}


@end
