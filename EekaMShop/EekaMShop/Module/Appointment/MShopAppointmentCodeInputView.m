//
//  MShopAppointmentCodeInputView.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/9.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentCodeInputView.h"
#import "MShopAppointmentDataItem.h"

@interface MShopAppointmentCodeInputView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIButton *_resendBtn;
    __weak IBOutlet UILabel *_tipsLabel;
    
    MShopAppointmentDataItem *m_dataItem;
}

@end

@implementation MShopAppointmentCodeInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.6];
    _bgImageView.image = MFImageStretchCenter(@"round");
}

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    m_dataItem = dataItem;
    
    if ([self.m_delegate respondsToSelector:@selector(verificationCodeSendedPhone)])
    {
        _tipsLabel.text = [NSString stringWithFormat:@"输入顾客手机%@收到的短信验证码",[self.m_delegate verificationCodeSendedPhone]];
    }
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
