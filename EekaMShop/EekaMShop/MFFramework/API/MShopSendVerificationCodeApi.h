//
//  MShopSendVerificationCodeApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/9/6.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopSendVerificationCodeApi : MFNetworkRequest

@property (nonatomic,strong) NSString *phone;

-(NSString *)verificationCode;

@end
