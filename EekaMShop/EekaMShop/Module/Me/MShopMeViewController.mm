//
//  MShopMeViewController.m
//  EekaMShop
//
//  Created by EEKA on 2017/7/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMeViewController.h"
#import "MShopLoginService.h"
#import "WWKApi.h"
#import "MFThirdPartyPlugin.h"
#import "MFGetSynMemberInfoApi.h"
#import "MShopSynMemberInfoModel.h"
#import <AddressBook/AddressBook.h>
#import "MFAppMacroUtil.h"
#import "MShopMeProfileCellView.h"
#import "MShopMeAddressBookSynCellView.h"

@interface MShopMeViewController ()
{
    MShopLoginService *m_loginService;
    
    __weak IBOutlet UILabel *_appVersionLabel;
    
    MFTableViewInfo *m_tableViewInfo;
    
    NSMutableArray *_synMemberInfoArray;
    BOOL _synProgressLabelHidden;
    NSString *_synProgressText;
    NSIndexPath *_synMemberInfoIndexPath;
}

@end

@implementation MShopMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    
    _synMemberInfoArray = [NSMutableArray array];
    
    m_tableViewInfo = [[MFTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.backgroundColor = [UIColor lightGrayColor];
    contentTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:contentTableView];
    
    _appVersionLabel.text = [NSString stringWithFormat:@"当前版本：%@",[MFAppMacroUtil getCFBundleVersion]];
    
    [self reloadMeView];
}

-(void)reloadMeView
{
    [m_tableViewInfo clearAllSection];
    
    [self addProfileSection];
    [self addFunctionSection];
}

-(void)addProfileSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeProfileCell:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:88.0f
                                                               userInfo:nil];
    [sectionInfo addCell:cellInfo];
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)addFunctionSection
{
    MFTableViewSectionInfo *sectionInfo = [MFTableViewSectionInfo sectionInfoDefault];
    
    if ([self needAddressBookCell])
    {
        [self getAddressBookAuthor];
        
        MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo cellForMakeSel:@selector(makeAddressBookCell:)
                                                                 makeTarget:self
                                                                  actionSel:@selector(synMemberInfo)
                                                               actionTarget:self
                                                                     height:90.0f
                                                                   userInfo:nil];
        [sectionInfo addCell:cellInfo];
    }
    
    [m_tableViewInfo addSection:sectionInfo];
    
}

- (void)makeProfileCell:(MFTableViewCell *)cell
{
    if (!cell.m_subContentView) {
        MShopMeProfileCellView *cellView = [MShopMeProfileCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    MShopMeProfileCellView *cellView = (MShopMeProfileCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    m_loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
    MShopLoginUserInfo *loginInfo = [m_loginService currentLoginUserInfo];
    
    [cellView setProfileCellInfo:loginInfo];
}

-(BOOL)needAddressBookCell
{
    return YES;
}

- (void)makeAddressBookCell:(MFTableViewCell *)cell
{
    if (!cell.m_subContentView) {
        MShopMeAddressBookSynCellView *cellView = [MShopMeAddressBookSynCellView nibView];
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    _synMemberInfoIndexPath = [contentTableView indexPathForCell:cell];
    
    MShopMeAddressBookSynCellView *cellView = (MShopMeAddressBookSynCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    [cellView setSynProgressLabel:_synProgressText hidden:_synProgressLabelHidden];
}

- (IBAction)onClickLogout:(id)sender {
    [m_loginService logout];
}

- (IBAction)onClickShare:(id)sender
{
    WWKSendMessageReq *req = [[WWKSendMessageReq alloc] init];
    WWKMessageLinkAttachment *attachment = [[WWKMessageLinkAttachment alloc] init];
    attachment.title = @"赢家M所APP分享";
    attachment.summary = @"建议在Safari上打开网页";
    attachment.url = @"https://www.eeka.info/eekamshop.html";
    attachment.iconurl = @"https://www.eeka.info/EekaMShop/mclubShare.png";
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [weakSelf cleanAddressBook];
        });
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
    
    dispatch_main_async_safe(^{
        [self showMBCircleInWindow];
    });
    
    ABAddressBookRef addressbookRef = ABAddressBookCreate();
    for (int i = 0; i < models.count; i++) {
        MShopSynMemberInfoModel *model = _synMemberInfoArray[i];
        
        ABRecordRef personRef = ABPersonCreate();
        CFErrorRef error = NULL;
        
        NSString *name = model.userName;
        NSString *phone = model.phone;
        NSString *note = [NSString stringWithFormat:@"维护员工-%@",model.maintainEmployeeName];
        NSDate *birthday = [MFStringUtil dateWithTimeString:model.birthday];
        
        name = [self fixedName:model.userName birthday:model.birthday maintainEmployeeName:model.maintainEmployeeName];
        
        ABRecordSetValue(personRef, kABPersonNoteProperty, (__bridge CFStringRef)note, &error);
        ABRecordSetValue(personRef, kABPersonFirstNameProperty, (__bridge CFStringRef)name, &error);
        ABRecordSetValue(personRef, kABPersonBirthdayProperty, (__bridge CFDateRef)birthday, &error);
        
        ABMultiValueRef phoneRef = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phoneRef, (__bridge CFStringRef)phone, kABPersonPhoneIPhoneLabel, NULL);
        
        ABRecordSetValue(personRef, kABPersonPhoneProperty, phoneRef, &error);
        
        ABAddressBookAddRecord(addressbookRef, personRef, nil);
        
        CFRelease(personRef);
        
        ABAddressBookSave(addressbookRef, NULL);
        
        dispatch_main_async_safe((^{
            _synProgressLabelHidden = NO;
            _synProgressText = [NSString stringWithFormat:@"正在同步 %@/%@",@(i),@(models.count)];
            [self reloadSynProgressIndexPath];
        }));
    }
    
    dispatch_main_async_safe((^{
        [self hiddenMBStatus];
        _synProgressLabelHidden = YES;
        [self reloadSynProgressIndexPath];
    }));
    
    CFRelease(addressbookRef);
}

-(NSString *)fixedName:(NSString *)name birthday:(NSString *)birthday maintainEmployeeName:(NSString *)maintainEmployeeName
{
    NSString *yearMonth = [MFStringUtil dateWithMMddString:birthday];
    NSString *fixName = [NSString stringWithFormat:@"%@(%@ %@)",name,yearMonth,maintainEmployeeName];
    return fixName;
}

-(void)cleanAddressBook
{
    dispatch_main_async_safe(^{
        [self showMBCircleInWindow];
    });
    
    ABAddressBookRef addressbookRef = ABAddressBookCreate();
    
    NSArray *addressbookArray = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressbookRef);
    for (id obj in addressbookArray)
    {
        NSInteger index = [addressbookArray indexOfObject:obj];
        
        ABRecordRef people = (__bridge ABRecordRef)obj;
        ABAddressBookRemoveRecord(addressbookRef, people, NULL);
        
        dispatch_main_async_safe((^{
            _synProgressLabelHidden = NO;
            _synProgressText = [NSString stringWithFormat:@"正在删除 %@/%@",@(index),@(addressbookArray.count)];
            [self reloadSynProgressIndexPath];
        }));
    }
    
    dispatch_main_async_safe(^{
        [self hiddenMBStatus];
        _synProgressLabelHidden = YES;
        [self reloadSynProgressIndexPath];
    });
    
    ABAddressBookSave(addressbookRef, NULL);
    CFRelease(addressbookRef);
}

-(void)reloadSynProgressIndexPath
{
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    [contentTableView reloadRowsAtIndexPaths:@[_synMemberInfoIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
