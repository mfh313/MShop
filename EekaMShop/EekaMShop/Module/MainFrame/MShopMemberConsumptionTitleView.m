//
//  MShopMemberConsumptionTitleView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberConsumptionTitleView.h"
#import "MShopIndividualConsumptionModel.h"

@interface MShopMemberConsumptionTitleView ()
{
    __weak IBOutlet UILabel *_saleNoLabel;
    __weak IBOutlet UILabel *_sellDateLabel;
    __weak IBOutlet UILabel *_trueReceLabel;
}

@end

@implementation MShopMemberConsumptionTitleView

-(void)setIndividualConsumptionTitleModel:(MShopIndividualConsumptionModel *)saleBillingItem
{
    _saleNoLabel.text = [NSString stringWithFormat:@"单号：%@",saleBillingItem.saleNo];
    _sellDateLabel.text = [NSString stringWithFormat:@"销售日期：%@",saleBillingItem.sellDate];
    _trueReceLabel.text = [MFStringUtil moneyDescWithNumber:saleBillingItem.trueRece];
}

@end
