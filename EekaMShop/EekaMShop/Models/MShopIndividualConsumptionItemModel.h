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
@property (nonatomic,strong) NSString *itemUrl;
@property (nonatomic,strong) NSString *itemCode;
@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) NSNumber *listPrice;
@property (nonatomic,strong) NSNumber *receivablePrice;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,strong) NSString *discountStr;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSNumber *point;
@property (nonatomic,strong) NSNumber *discountAmount; // 除折扣外优惠金额
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,strong) NSString *sellDate;
@property (nonatomic,strong) NSNumber *trueRece;
@property (nonatomic,strong) NSString *saleNo;

@end
