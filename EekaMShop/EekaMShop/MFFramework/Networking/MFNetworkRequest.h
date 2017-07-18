//
//  MFNetworkRequest.h
//  YJCustom
//
//  Created by EEKA on 16/9/27.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface MFNetworkRequest : YTKRequest

-(BOOL)messageSuccess;
-(NSString*)errorMessage;

@end
