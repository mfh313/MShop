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
    MShopLoginService *m_loginService;
}

@end

@implementation MShopMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    
    MShopLoginUserInfo *loginInfo = [m_loginService currentLoginUserInfo];
    
    _nameLabel.text = loginInfo.name;
}

- (IBAction)onClickLogout:(id)sender {
    [m_loginService logout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
