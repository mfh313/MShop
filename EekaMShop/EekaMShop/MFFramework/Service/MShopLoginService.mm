//
//  MShopLoginService.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginService.h"
#import "WWKApi.h"
#import <WCDB/WCDB.h>
#import "MShopSSOReqAttachObject.h"
#import "MShopLoginViewController.h"
#import "MShopAppViewControllerManager.h"
#import "MShopLoginService.h"
#import "MShopLoginUserInfo.h"


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


@end
