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
}

@end

@implementation MShopLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longGesture.minimumPressDuration = 3.0;
    [_WXLoginBtn addGestureRecognizer:longGesture];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
#ifdef DEBUG
    [self showTestLoginToast];
#else
    
#endif
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self showTestLoginToast];
    }
}

-(void)showTestLoginToast
{
    __weak typeof(self) weakSelf = self;
    
    NSString *shopKeeper = @"33766";
    NSString *clerk = @"42599";
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:@"店长登录-测试" actionBlock:^{
        [weakSelf onClickLoginUserId:shopKeeper];
    }];
    
    [alert addButton:@"店员登录-测试" actionBlock:^{
        [weakSelf onClickLoginUserId:clerk];
    }];
    
    UITextField *textField = [alert addTextField:@"输入userId"];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [alert addButton:@"使用输入的userId登录" actionBlock:^(void) {
        NSString *inputId = textField.text;
        NSString *numberRegex = @"[0-9]+";
        NSPredicate *numberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        
        if (![numberPred evaluateWithObject:inputId])
        {
            [self showTips:@"请输入数字" withDuration:2];
            return;
        }
        
        [weakSelf onClickLoginUserId:inputId];
    }];
    
    NSString *subTitle = [NSString stringWithFormat:@"可以选择固定的userId,也可以选择店长登录(%@),店员登录(%@)",shopKeeper,clerk];
    [alert showInfo:@"登陆测试" subTitle:subTitle closeButtonTitle:@"关闭弹窗" duration:0];
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

-(void)onClickLoginUserId:(NSString *)userId
{
    if ([MFStringUtil isBlankString:userId]) {
        [self showTips:@"userId是空！" withDuration:2];
        return;
    }
    
    MShopUserIdLoginApi *m_loginApi = [MShopUserIdLoginApi new];
    m_loginApi.userId = userId;
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
