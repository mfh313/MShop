//
//  MShopLoginService.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"
#import "MShopSSOReqAttachObject.h"

@interface MShopLoginService : MMService
{
    MShopSSOReqAttachObject *_waitAttachObject;
}

-(void)setWWKSSOReqAttachObject:(MShopSSOReqAttachObject *)attachObject;

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp;

@end
