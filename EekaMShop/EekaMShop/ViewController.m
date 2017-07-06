//
//  ViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "ViewController.h"
#import "WWKApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onClickWXLogin:(id)sender {
    WWKSSOReq *req = [[WWKSSOReq alloc] init];
    // state参数为这次请求的唯一标示，客户端需要维护其唯一性。SSO回调时会原样返回
    req.state = @"adfasdfasdf23412341fqw4df14t134rtflajssf8934haioefy";
    [WWKApi sendReq:req];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
