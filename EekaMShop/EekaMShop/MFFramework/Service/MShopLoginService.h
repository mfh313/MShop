//
//  MShopLoginService.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

@class MShopSSOReqAttachObject,WWKSSOResp,MShopLoginUserInfo;

@interface MShopLoginService : MMService
{
    MShopSSOReqAttachObject *_waitAttachObject;
    MShopLoginUserInfo *_currentLoginUserInfo;
}

-(NSString *)getCurrentLoginToken;

-(MShopLoginUserInfo *)currentLoginUserInfo;

-(void)setWWKSSOReqAttachObject:(MShopSSOReqAttachObject *)attachObject;

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp;

-(void)autoLogin;

-(void)logout;

-(void)updateLoginInfoInDB:(MShopLoginUserInfo *)info;
-(void)updateLastLoginInfoInDB:(MShopLoginUserInfo *)info;

@end
