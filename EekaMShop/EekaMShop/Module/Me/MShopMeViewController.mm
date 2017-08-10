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
#import <AddressBook/AddressBook.h>

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
    
    [self getAddressBookAuthor];
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
        
        [_synMemberInfoArray removeAllObjects];
        NSArray *synMemberInfoArray = request.responseObject;
        for (int i = 0; i < synMemberInfoArray.count; i++) {
            MShopSynMemberInfoModel *model = [MShopSynMemberInfoModel MM_modelWithJSON:synMemberInfoArray[i]];
            [_synMemberInfoArray addObject:model];
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf askIfAsynInfoToPhone];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
    
}

-(void)getAddressBookAuthor
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
    if (granted)
    {
        NSLog(@"授权成功！");
    }
    else
    {
        NSLog(@"授权失败!");
    }
    });
    CFRelease(addressBook);
}

-(void)askIfAsynInfoToPhone
{
    __weak typeof(self) weakSelf = self;
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:@"取消" actionBlock:nil];
    [alert addButton:@"清空联系人" actionBlock:^{
        [weakSelf cleanAddressBook];
    }];
    [alert addButton:@"确定" actionBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [weakSelf asynAddressBookInfo];
            
        });
    }];
    NSString *subTitle = [NSString stringWithFormat:@"是否同步%@个联系人到此设备通讯录",@(_synMemberInfoArray.count)];
    [alert showNotice:@"提醒" subTitle:subTitle closeButtonTitle:nil duration:0];
}

-(void)asynAddressBookInfo
{
    NSMutableArray *models = _synMemberInfoArray;
    
    ABAddressBookRef addressbookRef = ABAddressBookCreate();
    for (int i = 0; i < models.count; i++) {
        MShopSynMemberInfoModel *model = _synMemberInfoArray[i];
        
        ABRecordRef personRef = ABPersonCreate();
        CFErrorRef error = NULL;
        
        NSString *name = model.userName;
        NSString *phone = model.phone;
        NSString *note = [NSString stringWithFormat:@"维护员工-%@",model.maintainEmployeeName];
        NSDate *birthday = [MFStringUtil dateWithTimeString:model.birthday];
        
        ABRecordSetValue(personRef, kABPersonNoteProperty, (__bridge CFStringRef)note, &error);
        ABRecordSetValue(personRef, kABPersonFirstNameProperty, (__bridge CFStringRef)name, &error);
        ABRecordSetValue(personRef, kABPersonBirthdayProperty, (__bridge CFDateRef)birthday, &error);
        
        ABMultiValueRef phoneRef = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phoneRef, (__bridge CFStringRef)phone, kABPersonPhoneIPhoneLabel, NULL);
        
        ABRecordSetValue(personRef, kABPersonPhoneProperty, phoneRef, &error);
        
        ABAddressBookAddRecord(addressbookRef, personRef, nil);
        
        CFRelease(personRef);
        
        ABAddressBookSave(addressbookRef, NULL);
    }
    
    CFRelease(addressbookRef);
}

-(void)cleanAddressBook
{
    ABAddressBookRef addressbookRef = ABAddressBookCreate();
    
    NSArray *addressbookArray = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressbookRef);
    for (id obj in addressbookArray)
    {
        ABRecordRef people = (__bridge ABRecordRef)obj;
        ABAddressBookRemoveRecord(addressbookRef, people, NULL);
    }
    
    ABAddressBookSave(addressbookRef, NULL);
    CFRelease(addressbookRef);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
