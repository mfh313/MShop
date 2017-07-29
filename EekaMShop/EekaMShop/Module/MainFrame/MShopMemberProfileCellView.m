//
//  MShopMemberProfileCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberProfileCellView.h"
#import "UIImageView+CornerRadius.h"
#import "XWScanImage.h"

@interface MShopMemberProfileCellView ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
}

@end

@implementation MShopMemberProfileCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_avtarImageView zy_cornerRadiusAdvance:5.0f rectCornerType:UIRectCornerAllCorners];
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_avtarImageView addGestureRecognizer:tapGestureRecognizer1];
    [_avtarImageView setUserInteractionEnabled:YES];
}

-(void)scanBigImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

-(void)setIndividualInfo:(NSString *)avtar name:(NSString *)name
{
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:avtar] placeholderImage:MFImage(@"avtar")];
    _nameLabel.text = name;
}

@end
