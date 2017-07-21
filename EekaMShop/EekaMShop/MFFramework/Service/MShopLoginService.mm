//
//  MShopLoginService.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopLoginService.h"
#import "WWKApi.h"
#import "MShopSSOReqAttachObject.h"
#import "MShopLoginViewController.h"
#import "MShopAppViewControllerManager.h"
#import "MShopLoginTable.h"
#import "MShopLoginTable+WCDB.h"
#import "MShopLoginUserInfo.h"
#import "MShopLoginUserInfo+WCDB.h"
#import <WCDB/WCDB.h>


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
    if (![MFStringUtil isBlankString:[self getCurrentLoginToken]])
    {
        [[MShopAppViewControllerManager getAppViewControllerManager] createMainTabViewController];
    }
    else
    {
        [[MShopAppViewControllerManager getAppViewControllerManager] jumpToLoginViewController];
    }
}

-(void)logout
{
    _currentLoginUserInfo = nil;
    
    Class cls = MShopLoginUserInfo.class;
    NSString *tableName = NSStringFromClass(cls);
    
    NSString *path = [self MShopLoginUserInfoPath];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:cls];
    [table deleteAllObjects];
    
    [self deleteLastLoginInfoInDB];
    
    [[MShopAppViewControllerManager getAppViewControllerManager] userLogOut];
    [[MShopAppViewControllerManager getAppViewControllerManager] jumpToLoginViewController];
}

-(MShopLoginUserInfo *)currentLoginUserInfo
{
    if (_currentLoginUserInfo) {
        return _currentLoginUserInfo;
    }
    
    Class cls = MShopLoginUserInfo.class;
    NSString *tableName = NSStringFromClass(cls);
    NSString *path = [self MShopLoginUserInfoPath];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:cls];
    MShopLoginUserInfo *loginInfo = [table getOneObject];
    return loginInfo;
}

-(NSString *)getCurrentLoginToken
{
    NSString *className = NSStringFromClass(MShopLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:MShopLoginTable.class];
    MShopLoginTable *loginInfo = [table getOneObject];
    return loginInfo.token;
}

-(NSString *)MShopLoginUserInfoPath
{
    Class cls = MShopLoginUserInfo.class;
    NSString *fileName = NSStringFromClass(cls);
    
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:fileName];
    return path;
}

-(void)updateLoginInfoInDB:(MShopLoginUserInfo *)info
{
    Class cls = MShopLoginUserInfo.class;
    NSString *tableName = NSStringFromClass(cls);
    
    NSString *path = [self MShopLoginUserInfoPath];
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
    
    
    [database insertObject:(WCTObject *)info into:tableName];
}

-(void)updateLastLoginInfoInDB:(MShopLoginUserInfo *)info
{
    NSString *className = NSStringFromClass(MShopLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    [database close:^{
        [database removeFilesWithError:nil];
    }];
    
    [database createTableAndIndexesOfName:tableName
                                withClass:MShopLoginTable.class];
    
    
    WCTTable *table = [database getTableOfName:tableName
                               withClass:MShopLoginTable.class];
    
    
    MShopLoginTable *object = [[MShopLoginTable alloc] init];
    object.token = info.token;
    object.userId = info.userId;
    object.createTime = [NSDate date];
    object.modifiedTime = [NSDate date];
    [table insertObject:object];
}

-(void)deleteLastLoginInfoInDB
{
    NSString *className = NSStringFromClass(MShopLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:MShopLoginTable.class];
    [table deleteAllObjects];
}

@end
