//
//  MShopLoginViewController.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWKSSOResp;
@interface MShopLoginViewController : MMViewController

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp;

@end
