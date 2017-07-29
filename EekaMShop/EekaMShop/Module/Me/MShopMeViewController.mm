//
//  MShopMeViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMeViewController.h"
#import "MShopLoginService.h"
#import "UIImageView+CornerRadius.h"
#import "WWKApi.h"
#import "MFThirdPartyPlugin.h"

@interface MShopMeViewController ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_positionLabel;
    
    MShopLoginService *m_loginService;
}

@end

@implementation MShopMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    [_avtarImageView zy_cornerRadiusAdvance:5.0f rectCornerType:UIRectCornerAllCorners];
    
    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *loginInfo = [m_loginService currentLoginUserInfo];
    
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:loginInfo.avatar]];
    _nameLabel.text = loginInfo.name;
    _positionLabel.text = loginInfo.position;
}

- (IBAction)onClickLogout:(id)sender {
    [m_loginService logout];
}

- (IBAction)onClickShare:(id)sender
{
    WWKSendMessageReq *req = [[WWKSendMessageReq alloc] init];
    WWKMessageLinkAttachment *attachment = [[WWKMessageLinkAttachment alloc] init];
    attachment.title = @"赢家M所APP测试版分享";
    attachment.summary = @"请在Safari上打开网页，并选择下载赢家MClub";
    attachment.url = @"https://www.eeka.info/index_test.html";
    attachment.icon = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mclubShare" ofType:@"png"]];
    req.attachment = attachment;
    [WWKApi sendReq:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
