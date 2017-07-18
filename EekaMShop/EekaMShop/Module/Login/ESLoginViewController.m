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
    req.state = @"adfasdfasdf23412341fqw4df14t134rtflajssf8934haioefy";
    [WWKApi sendReq:req];
    
    BOOL open = [WWKApi openApp];
    if (!open) {
        [self showTips:@"请安装企业微信"];
        return;
    }
    
    
}



@end
