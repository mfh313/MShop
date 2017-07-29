//
//  MShopIndividualConsumptionModel.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopIndividualConsumptionModel.h"
#import "MShopIndividualConsumptionItemModel.h"

@implementation MShopIndividualConsumptionModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"orderNum" : @"order_num",
//             @"orderServeArray" : @"orderServeList",
//             @"orderProdArray" : @"orderProdList"
//             };
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemList" : [MShopIndividualConsumptionItemModel class]};
}

@end
