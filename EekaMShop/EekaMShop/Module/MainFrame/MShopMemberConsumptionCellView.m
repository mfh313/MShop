//
//  MShopMemberConsumptionCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMemberConsumptionCellView.h"
#import "MShopIndividualConsumptionModel.h"

@interface MShopMemberConsumptionCellView ()
{
    __weak IBOutlet UILabel *_saleNoLabel;
    __weak IBOutlet UILabel *_sellDateLabel;
    __weak IBOutlet UILabel *_trueReceLabel;
}

@end

@implementation MShopMemberConsumptionCellView

-(void)setIndividualConsumption:(MShopIndividualConsumptionModel *)saleBillingItem
{
    _saleNoLabel.text = [NSString stringWithFormat:@"单号：%@",saleBillingItem.saleNo];
    _sellDateLabel.text = [NSString stringWithFormat:@"销售日期：%@",saleBillingItem.sellDate];
    _trueReceLabel.text = [self moneyDescWithNumber:saleBillingItem.trueRece];
}

-(NSString *)moneyDescWithNumber:(NSNumber *)money
{
    return [NSString stringWithFormat:@"¥ %.2f ",money.floatValue];
}

@end
