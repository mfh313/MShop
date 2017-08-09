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
#import "XWScanImage.h"
#import "MFGetSynMemberInfoApi.h"
#import "MShopSynMemberInfoModel.h"

@interface MShopMeViewController ()
{
    __weak IBOutlet UIImageView *_avtarImageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_positionLabel;
    
    MShopLoginService *m_loginService;
    
    __weak IBOutlet UILabel *_appVersionLabel;
    NSMutableArray *_synMemberInfoArray;
}

@end

@implementation MShopMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    [_avtarImageView zy_cornerRadiusAdvance:5.0f rectCornerType:UIRectCornerAllCorners];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_avtarImageView addGestureRecognizer:tapGestureRecognizer1];
    [_avtarImageView setUserInteractionEnabled:YES];
    
    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *loginInfo = [m_loginService currentLoginUserInfo];
    
    [_avtarImageView sd_setImageWithURL:[NSURL URLWithString:loginInfo.avatar]];
    _nameLabel.text = loginInfo.name;
    _positionLabel.text = loginInfo.position;
    
    _appVersionLabel.text = [NSString stringWithFormat:@"当前版本：%@",[self getNowBundleVersion]];
    
    _synMemberInfoArray = [NSMutableArray array];
}

- (NSString *)getNowBundleVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

-(void)scanBigImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

- (IBAction)onClickSynMemBerInfo:(id)sender {
    [self synMemberInfo];
}

- (IBAction)onClickLogout:(id)sender {
    [m_loginService logout];
}

- (IBAction)onClickShare:(id)sender
{
    WWKSendMessageReq *req = [[WWKSendMessageReq alloc] init];
    WWKMessageLinkAttachment *attachment = [[WWKMessageLinkAttachment alloc] init];
    attachment.title = @"赢家M所APP测试版分享";
    attachment.summary = @"建议在Safari上打开网页";
    attachment.url = @"https://www.eeka.info/eekamshop_test.html";
    attachment.iconurl = @"https://www.eeka.info/EekaMShop_test/mclubShare.png";
    req.attachment = attachment;
    [WWKApi sendReq:req];
}

-(void)synMemberInfo
{
    __weak typeof(self) weakSelf = self;
    
    MFGetSynMemberInfoApi *mfApi = [MFGetSynMemberInfoApi new];
    mfApi.animatingText = @"正在同步会员信息到通讯录...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            [self showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *synMemberInfoArray = request.responseObject;
        for (int i = 0; i < synMemberInfoArray.count; i++) {
            MShopSynMemberInfoModel *model = [MShopSynMemberInfoModel MM_modelWithJSON:synMemberInfoArray[i]];
            [_synMemberInfoArray addObject:model];
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf asynInfoToPhone];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
    
}


-(void)asynInfoToPhone
{
    //1.是否清空联系人
    //2.同步联系人
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
