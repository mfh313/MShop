//
//  MShopMeProfileCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMeProfileCellView.h"
#import "MShopLoginService.h"
#import "UIImageView+CornerRadius.h"
#import "XWScanImage.h"

@interface MShopMeProfileCellView ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_positionLabel;
}

@end

@implementation MShopMeProfileCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_avtarImageView zy_cornerRadiusAdvance:5.0f rectCornerType:UIRectCornerAllCorners];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_avtarImageView addGestureRecognizer:tapGestureRecognizer1];
    [_avtarImageView setUserInteractionEnabled:YES];
}

-(void)setProfileCellInfo:(MShopLoginUserInfo *)loginInfo
{
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:loginInfo.avatar]];
    _nameLabel.text = loginInfo.name;
    _positionLabel.text = loginInfo.position;
}

-(void)scanBigImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

@end
