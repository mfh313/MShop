//
//  MShopLoginApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopLoginApi : MFNetworkRequest

@property (nonatomic,strong) NSString *code;

-(BOOL)loginSuccess;

@end
