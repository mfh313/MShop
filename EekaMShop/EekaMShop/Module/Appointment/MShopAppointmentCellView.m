//
//  MShopAppointmentCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentCellView.h"
#import "MShopAppointmentDataItem.h"

@interface MShopAppointmentCellView ()
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_depNameLabel;
}

@end

@implementation MShopAppointmentCellView

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    _titleLabel.text = [self titleDataItem:dataItem];
    _timeLabel.text = [NSString stringWithFormat:@"预约时间：%@ %@",dataItem.appointmentDate,dataItem.appointmentTime];
    _depNameLabel.text = [NSString stringWithFormat:@"预约单号：%@",dataItem.appointmentNo];
}

-(NSString *)titleDataItem:(MShopAppointmentDataItem *)dataItem
{
    return [NSString stringWithFormat:@"%@预约了%@",dataItem.individualName,dataItem.type];
}

@end
