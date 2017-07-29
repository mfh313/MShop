//
//  MShopIndividualConsumptionItemModel.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MShopIndividualConsumptionItemModel : NSObject

@property (nonatomic,strong) NSNumber *saleBillingItemID;
@property (nonatomic,strong) NSNumber *saleBillingID;
@property (nonatomic,strong) NSNumber *itemID;
@property (nonatomic,strong) NSString *itemCode;
@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) NSNumber *listPrice;
@property (nonatomic,strong) NSNumber *receivablePrice;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,strong) NSString *discountStr;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSNumber *discountAmount;
@property (nonatomic,strong) NSNumber *number;

@end
