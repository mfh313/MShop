//
//  MFNetworkRequest.h
//  YJCustom
//
//  Created by EEKA on 16/9/27.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBatchRequest.h>
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface MFNetworkRequest : YTKRequest

-(BOOL)useToken;
-(BOOL)messageSuccess;
-(NSString*)errorMessage;

@end
