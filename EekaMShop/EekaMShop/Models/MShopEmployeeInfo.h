//
//  MShopEmployeeInfo.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MShopEmployeeInfo : NSObject 

@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *department;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *englishName;
@property (nonatomic,strong) NSString *extattr;
@property (nonatomic,strong) NSNumber *gender;
@property (nonatomic,assign) BOOL isLeader;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *telephone;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,assign) int timestamp;



@end
