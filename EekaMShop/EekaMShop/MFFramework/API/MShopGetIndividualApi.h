//
//  MShopGetIndividualApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/25.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopGetIndividualApi : MFNetworkRequest

@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,strong) NSString *phone;

@end
