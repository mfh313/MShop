//
//  ESLoginViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "ESLoginViewController.h"
#import "WWKApi.h"
#import "MShopLoginApi.h"
#import "MShopLoginService.h"
#import "MShopSSOReqAttachObject.h"
#import "ESLoginViewController.h"

@interface ESLoginViewController ()

@end

@implementation ESLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onClickWXLogin:(id)sender {

//    BOOL isAppInstalled = [WWKApi isAppInstalled];
//    if (!isAppInstalled) {
//        [self showTips:@"请安装企业微信"];
//        return;
//    }
    
    WWKSSOReq *req = [[WWKSSOReq alloc] init];
    req.state = @"ESLoginViewController";
    
    MShopSSOReqAttachObject *attachObject = [MShopSSOReqAttachObject new];
    attachObject.key = NSStringFromClass(self.class);
    attachObject.delegate = self;
    attachObject.state = req.state;
    
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    [loginService setWWKSSOReqAttachObject:attachObject];
    
    
    [WWKApi sendReq:req];
}


-(void)loginWithWWKCode:(NSString *)code
{    
    if ([MFStringUtil isBlankString:code]) {
        [self showTips:@"请无此权限，请联系管理员"];
        return;
    }
    
    
}

@end
