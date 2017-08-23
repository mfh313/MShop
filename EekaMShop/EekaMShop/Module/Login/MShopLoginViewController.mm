//
//  MShopLoginViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginViewController.h"
#import <WCDB/WCDB.h>
#import "WWKApi.h"
#import "MShopLoginApi.h"
#import "MShopLoginService.h"
#import "MShopSSOReqAttachObject.h"
#import "MShopLoginViewController.h"
#import "MShopLoginUserInfo.h"
#import "MShopAppViewControllerManager.h"
#import "MShopUserIdLoginApi.h"
#import "MFThirdPartyPlugin.h"

@interface MShopLoginViewController ()
{
    __weak IBOutlet UIButton *_WXLoginBtn;
    __weak IBOutlet UIButton *_dianZBtn;
    __weak IBOutlet UIButton *_dianYBtn;
}

@end

@implementation MShopLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifdef DEBUG
    [self setTestBtnHidden:NO];
#else
    [self setTestBtnHidden:YES];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longGesture.minimumPressDuration = 2.0;
    [_WXLoginBtn addGestureRecognizer:longGesture];
    
#endif
    
}

-(void)setTestBtnHidden:(BOOL)hidden
{
    [_dianZBtn setHidden:hidden];
    [_dianYBtn setHidden:hidden];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self setTestBtnHidden:NO];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {

    }
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

-(void)loginWithWWKSSOResp:(WWKSSOResp *)resp
{
    if (resp.errCode == WWKBaseRespErrCodeOK) {
        [self loginWithWWKCode:resp.code];
    }
    else if (resp.errCode == WWKBaseRespErrCodeCancelled) {
        [self showTips:@"您取消了登陆"];
    }
}

-(void)loginWithWWKCode:(NSString *)code
{    
    if ([MFStringUtil isBlankString:code]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    MShopLoginApi *m_loginApi = [MShopLoginApi new];
    m_loginApi.code = code;
    m_loginApi.animatingText = @"正在登录...";
    m_loginApi.animatingView = MFAppWindow;
    [m_loginApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!m_loginApi.messageSuccess) {
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

- (IBAction)onClickMangerLogin:(id)sender
{
    MShopUserIdLoginApi *m_loginApi = [MShopUserIdLoginApi new];
    [m_loginApi mangerLogin];
    [self userIdLogin:m_loginApi];
}

- (IBAction)onClickClerkLogin:(id)sender
{
    MShopUserIdLoginApi *m_loginApi = [MShopUserIdLoginApi new];
    [m_loginApi clerkLogin];
    [self userIdLogin:m_loginApi];
}

-(void)userIdLogin:(MShopUserIdLoginApi *)m_loginApi
{
    __weak typeof(self) weakSelf = self;
    
    m_loginApi.animatingText = @"正在登录...";
    m_loginApi.animatingView = MFAppWindow;
    [m_loginApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!m_loginApi.messageSuccess) {
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
    MFThirdPartyPlugin *thirdPartyPlugin = [[MMServiceCenter defaultCenter] getService:[MFThirdPartyPlugin class]];
    [thirdPartyPlugin setJPushTAG];
    [[MShopAppViewControllerManager getAppViewControllerManager] createMainTabViewController];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
