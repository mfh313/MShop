//
//  MShopLoginTable.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MShopLoginTable : NSObject 

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSDate *createTime;
@property (nonatomic,strong) NSDate *modifiedTime;


@end
