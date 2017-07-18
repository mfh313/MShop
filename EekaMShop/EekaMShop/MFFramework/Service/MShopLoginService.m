//
//  MShopLoginService.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginService.h"
#import "MShopSSOReqAttachObject.h"
#import "WWKApi.h"
#import "ESLoginViewController.h"

@implementation MShopLoginService

-(void)setWWKSSOReqAttachObject:(MShopSSOReqAttachObject *)attachObject
{
    _waitAttachObject = attachObject;
}

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp
{
    id vcObject = _waitAttachObject.delegate;
    if ([vcObject isKindOfClass:[ESLoginViewController class]]) {
        ESLoginViewController *loginVC = (ESLoginViewController *)vcObject;
        [loginVC loginWithWWKCode:resp.code];
    }
}

@end
