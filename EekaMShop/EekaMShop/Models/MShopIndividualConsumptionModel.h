//
//  MShopIndividualConsumptionModel.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopIndividualConsumptionModel : MFNetworkRequest

@property (nonatomic,strong) NSNumber *saleBillingID;
@property (nonatomic,strong) NSString *deptName;
@property (nonatomic,strong) NSString *guider;
@property (nonatomic,strong) NSString *cashier;
@property (nonatomic,strong) NSString *sellDate;
@property (nonatomic,strong) NSString *printDate;
@property (nonatomic,strong) NSNumber *amountPrice;
@property (nonatomic,strong) NSNumber *trueRece;
@property (nonatomic,strong) NSNumber *replaceFlag;
@property (nonatomic,strong) NSNumber *actualRece;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,strong) NSNumber *isDelete;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *deductionStr;
@property (nonatomic,strong) NSString *posvoucherId;
@property (nonatomic,strong) NSString *payType;
@property (nonatomic,strong) NSString *saleNo;
@property (nonatomic,strong) NSString *deptId;
@property (nonatomic,strong) NSArray *itemList;
@property (nonatomic,strong) NSNumber *discountAmount;
@property (nonatomic,strong) NSNumber *itemSize;
@property (nonatomic,strong) NSNumber *xianJin; //"现金"
@property (nonatomic,strong) NSNumber *CSCard;  //"储值卡"
@property (nonatomic,strong) NSNumber *bankCard; //"银行卡"
@property (nonatomic,strong) NSNumber *weiXin;   //"微信钱包"
@property (nonatomic,strong) NSNumber *zhiFuBao;  //"支付宝钱包"
@property (nonatomic,strong) NSNumber *saleBillingItemID;
@property (nonatomic,strong) NSNumber *itemID;
@property (nonatomic,strong) NSString *itemCode;
@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) NSNumber *listPrice;
@property (nonatomic,strong) NSNumber *receivablePrice;
@property (nonatomic,strong) NSNumber *itemDiscount;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,strong) NSString *individualName;

@end
