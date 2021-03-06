//
//  MShopMemberConsumptionCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberConsumptionCellView.h"
#import "MShopIndividualConsumptionItemModel.h"

@interface MShopMemberConsumptionCellView ()
{
    __weak IBOutlet UIImageView *_itemImageView;
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_itemNameLabel;
    __weak IBOutlet UILabel *_trueReceLabel;
}

@end

@implementation MShopMemberConsumptionCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setIndividualConsumptionItem:(MShopIndividualConsumptionItemModel *)saleBillingItem
{
    [_itemImageView sd_setImageWithURL:[NSURL URLWithString:saleBillingItem.pictureUrl] placeholderImage:MFImage(@"noImage")];
    _itemCodeLabel.text = saleBillingItem.itemCode;
    _itemNameLabel.text = saleBillingItem.itemName;
    _trueReceLabel.text = [MFStringUtil moneyDescWithNumber:saleBillingItem.receivablePrice];
}

@end
