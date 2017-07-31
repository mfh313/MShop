//
//  MShopMemberConsumptionCellView.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class MShopIndividualConsumptionItemModel;
@interface MShopMemberConsumptionCellView : MMUIBridgeView

-(void)setIndividualConsumptionItem:(MShopIndividualConsumptionItemModel *)saleBillingItem;

@end
