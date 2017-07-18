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
    WWKSSOReq *req = [[WWKSSOReq alloc] init];
    // state参数为这次请求的唯一标示，客户端需要维护其唯一性。SSO回调时会原样返回
    req.state = @"ESLoginViewController";
    [WWKApi sendReq:req];
    
    BOOL open = [WWKApi openApp];
    if (!open) {
        [self showTips:@"请安装企业微信"];
        return;
    }
    
    MShopSSOReqAttachObject *attachObject = [MShopSSOReqAttachObject new];
    attachObject.key = NSStringFromClass(self.class);
    attachObject.delegate = self;
    attachObject.state = req.state;
    
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    [loginService setWWKSSOReqAttachObject:attachObject];
}


-(void)loginWithWWKCode:(NSString *)code
{
    
}

@end
