//
//  MShopAppointmentDateSelectView.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/8.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentDateSelectView.h"

@interface MShopAppointmentDateSelectView ()
{
    __weak IBOutlet UIButton *_doneBtn;
}

@end

@implementation MShopAppointmentDateSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [_doneBtn setBackgroundImage:MFImageStretchCenter(@"border_pink") forState:UIControlStateNormal];
}

- (IBAction)onClickDoneButton:(id)sender
{
    [self removeFromSuperview];
    
    if ([self.m_delegate respondsToSelector:@selector(onClickDoneButton:)]) {
        [self.m_delegate onClickDoneButton:self];
    }
    
    if ([self.m_delegate respondsToSelector:@selector(didSetAppointmentDate:appointmentTime:selectView:)]) {
        [self.m_delegate didSetAppointmentDate:@"2017-09-09" appointmentTime:@"12:00-13:00" selectView:self];
    }
}


@end
