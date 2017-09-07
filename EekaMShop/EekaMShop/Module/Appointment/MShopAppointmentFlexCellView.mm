//
//  MShopAppointmentFlexCellView.m
//  EekaMShop
//
//  Created by mafanghua on 2017/9/7.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentFlexCellView.h"
#import "MShopAppointmentDataItem.h"
#import <VZFlexLayout/VZFlexLayout.h>

using namespace VZ;

@implementation MShopAppointmentFlexCellView

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    NSString *title = [self titleDataItem:dataItem];
    NSString *time = [NSString stringWithFormat:@"预约时间：%@ %@",dataItem.appointmentDate,dataItem.appointmentTime];
    NSString *appointmentNo = [NSString stringWithFormat:@"预约单号：%@",dataItem.appointmentNo];
    
    
}

-(NSString *)titleDataItem:(MShopAppointmentDataItem *)dataItem
{
    return [NSString stringWithFormat:@"%@预约了%@",dataItem.individualName,dataItem.type];
}

@end
