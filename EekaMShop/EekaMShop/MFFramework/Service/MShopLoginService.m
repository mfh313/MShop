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
#import "MShopLoginViewController.h"
#import "MShopAppViewControllerManager.h"

@implementation MShopLoginService

-(void)setWWKSSOReqAttachObject:(MShopSSOReqAttachObject *)attachObject
{
    _waitAttachObject = attachObject;
}

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp
{
    id attachObject = _waitAttachObject.delegate;
    if ([attachObject isKindOfClass:[MShopLoginViewController class]]) {
        MShopLoginViewController *loginVC = (MShopLoginViewController *)attachObject;
        [loginVC loginWithWWKCode:resp.code];
    }
}

-(void)autoLogin
{
    //order by
    //查找上次最后登陆
    
    
    [[MShopAppViewControllerManager getAppViewControllerManager] jumpToLoginViewController];
}


@end
