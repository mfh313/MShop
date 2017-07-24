//
//  MShopLoginService.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"
#import "MShopLoginUserInfo.h"

@class MShopSSOReqAttachObject,WWKSSOResp;

@interface MShopLoginService : MMService
{
    MShopSSOReqAttachObject *_waitAttachObject;
    MShopLoginUserInfo *_currentLoginUserInfo;
}

-(NSString *)getCurrentLoginToken;

-(MShopLoginUserInfo *)currentLoginUserInfo;

-(NSString *)currentLoginUserDepartment;

-(void)setWWKSSOReqAttachObject:(MShopSSOReqAttachObject *)attachObject;

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp;

-(void)autoLogin;

-(void)logout;

-(void)updateLoginInfoInDB:(MShopLoginUserInfo *)info;
-(void)updateLastLoginInfoInDB:(MShopLoginUserInfo *)info;

@end
