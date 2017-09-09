//
//  MShopAppointmentCodeInputView.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/9.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentCodeInputView.h"
#import "MShopAppointmentDataItem.h"
#import "JhtVerificationCodeView.h"

@interface MShopAppointmentCodeInputView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIButton *_resendBtn;
    __weak IBOutlet UILabel *_tipsLabel;
    __weak IBOutlet UIView *_verificationCodeBgView;
    
    MShopAppointmentDataItem *m_dataItem;
    
    JhtVerificationCodeView *m_verificationCodeView;
}

@end

@implementation MShopAppointmentCodeInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.6];
    _bgImageView.image = MFImageStretchCenter(@"round");
}

-(void)initVerificationCodeView
{
    m_verificationCodeView = [[JhtVerificationCodeView alloc] initWithFrame:_verificationCodeBgView.bounds];
    m_verificationCodeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_verificationCodeView.total = self.numberOfVertificationCode;
    m_verificationCodeView.hasBoder = YES;
    m_verificationCodeView.boderColor = [UIColor hx_colorWithHexString:@"0080C0"];
    m_verificationCodeView.codeViewType = VerificationCodeViewType_Custom;
    [_verificationCodeBgView addSubview:m_verificationCodeView];
    
    m_verificationCodeView.endEditBlcok = ^(NSString *text) {
        NSLog(@"输入的验证码为：%@", text);
    };
}

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    m_dataItem = dataItem;
    
    if ([self.m_delegate respondsToSelector:@selector(verificationCodeSendedPhone)])
    {
        _tipsLabel.text = [NSString stringWithFormat:@"输入顾客手机%@收到的短信验证码",[self.m_delegate verificationCodeSendedPhone]];
    }
    
    [m_verificationCodeView removeFromSuperview];
    m_verificationCodeView = nil;
    [self initVerificationCodeView];
    
    [m_verificationCodeView Jht_BecomeFirstResponder];
}

- (IBAction)onClickCancelButton:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)onClickResend:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickResendVerificationCode:)])
    {
        [self.m_delegate onClickResendVerificationCode:m_dataItem.individualPhone];
    }
}

@end
