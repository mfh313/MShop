//
//  MShopLoginViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginViewController.h"
#import "WWKApi.h"
#import "MShopLoginApi.h"
#import "MShopLoginService.h"
#import "MShopSSOReqAttachObject.h"
#import "MShopLoginViewController.h"
#import "MShopLoginUserInfo.h"
#import "MShopAppViewControllerManager.h"
#import <WCDB/WCDB.h>

@interface MShopLoginViewController ()
{
    
}

@end

@implementation MShopLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onClickWXLogin:(id)sender {
    
    BOOL authentication = [self startWWKAuthentication];
    if (!authentication) {
        [self showTips:@"请安装企业微信"];
    }
}

-(BOOL)startWWKAuthentication
{
    BOOL isAppInstalled = [WWKApi isAppInstalled];
    if (!isAppInstalled) {
        return NO;
    }
    
    WWKSSOReq *req = [[WWKSSOReq alloc] init];
    req.state = NSStringFromClass(self.class);
    
    MShopSSOReqAttachObject *attachObject = [MShopSSOReqAttachObject new];
    attachObject.key = NSStringFromClass(self.class);
    attachObject.delegate = self;
    attachObject.state = req.state;
    
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    [loginService setWWKSSOReqAttachObject:attachObject];
    
    [WWKApi sendReq:req];
    
    return YES;
}

-(void)loginWithWWKCode:(NSString *)code
{    
    if ([MFStringUtil isBlankString:code]) {
        [self showTips:@"未获取权限"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    MShopLoginApi *m_loginApi = [MShopLoginApi new];
    m_loginApi.code = code;
    m_loginApi.animatingText = @"正在登录...";
    m_loginApi.animatingView = MFAppWindow;
    [m_loginApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!m_loginApi.loginSuccess) {
            [self showTips:m_loginApi.errorMessage];
            return;
        }
        
        MShopLoginUserInfo *loginInfo = [MShopLoginUserInfo MM_modelWithJSON:request.responseJSONObject];
        loginInfo.token = [MFStringUtil URLEncodedString:loginInfo.token];
        
        MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
        [loginService updateLoginInfoInDB:loginInfo];
        [loginService updateLastLoginInfoInDB:loginInfo];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf onDidLoginSuccess];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

-(void)onDidLoginSuccess
{
    [[MShopAppViewControllerManager getAppViewControllerManager] createMainTabViewController];
}

@end
