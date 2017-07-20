//
//  MShopMeViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMeViewController.h"
#import "MShopLoginService.h"
#import "MShopLoginUserInfo.h"

@interface MShopMeViewController ()
{
    __weak IBOutlet UILabel *_nameLabel;
}

@end

@implementation MShopMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    
    MShopLoginUserInfo *loginInfo = [loginService currentLoginUserInfo];
    
    _nameLabel.text = loginInfo.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
