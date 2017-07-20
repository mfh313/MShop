//
//  MFNetWorkAgent.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

@class MFNetworkRequest;
@interface MFNetWorkAgent : MMService

-(BOOL)tokenExpire:(MFNetworkRequest *)request;

-(void)handleTokenExpire;

@end
