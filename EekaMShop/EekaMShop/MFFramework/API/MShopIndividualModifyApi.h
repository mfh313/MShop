//
//  MShopIndividualModifyApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@class MShopIndividualInfo;
@interface MShopIndividualModifyApi : MFNetworkRequest

@property (nonatomic,strong) MShopIndividualInfo *individualInfo;

@end
