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

    BOOL isAppInstalled = [WWKApi isAppInstalled];
    if (!isAppInstalled) {
        [self showTips:@"请安装企业微信"];
        return;
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
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf updateLoginInfoInDB:loginInfo];
        [strongSelf onDidLoginSuccess];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

-(void)updateLoginInfoInDB:(MShopLoginUserInfo *)info
{
    Class cls = MShopLoginUserInfo.class;
    NSString *fileName = NSStringFromClass(cls);
    NSString *tableName = NSStringFromClass(cls);
    
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:fileName];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    [database close:^{
        [database removeFilesWithError:nil];
    }];
    
    BOOL ret = [database createTableAndIndexesOfName:tableName withClass:cls];
    assert(ret);
    
    NSArray *schemas = [database getAllObjectsOnResults:{WCTMaster.name, WCTMaster.sql} fromTable:WCTMaster.TableName];
    for (WCTMaster *table : schemas) {
        NSLog(@"SQL Of %@: %@", table.name, table.sql);
    }
    

    [database insertObject:info into:tableName];
}

-(void)onDidLoginSuccess
{
    [[MShopAppViewControllerManager getAppViewControllerManager] createMainTabViewController];
}

@end
