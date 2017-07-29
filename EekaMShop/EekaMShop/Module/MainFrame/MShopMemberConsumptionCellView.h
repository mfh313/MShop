//
//  MShopMemberConsumptionCellView.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class MShopIndividualConsumptionModel;
@interface MShopMemberConsumptionCellView : MMUIBridgeView

-(void)setIndividualConsumption:(MShopIndividualConsumptionModel *)saleBillingItem;

@end
