//
//  MFNetworkRequest.h
//  YJCustom
//
//  Created by EEKA on 16/9/27.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "YTKRequest.h"
#import "YTKBatchRequest.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface MFNetworkRequest : YTKRequest

-(BOOL)messageSuccess;
-(NSString*)errorMessage;

@end
