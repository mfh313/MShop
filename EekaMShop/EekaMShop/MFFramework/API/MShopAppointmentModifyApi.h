//
//  MShopAppointmentModifyApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@class MShopAppointmentDataItem;

@interface MShopAppointmentModifyApi : MFNetworkRequest

@property (nonatomic,strong) MShopAppointmentDataItem *dataItem;

@end
