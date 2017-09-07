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
    
    [self removeAllSubViews];
    self.backgroundColor = [UIColor lightGrayColor];
    
    NodeLayout layout = [self titleNodeForTitle:title];
    UIView *contentView = viewForRootNode(layout, self.frame.size);
    [self addSubview:contentView];
}

-(NodeLayout)titleNodeForTitle:(NSString *)appointmentTitle
{
    VZFTextNode *titleNode = [VZFTextNode newWithTextAttributes:
                             {
                                 .text = appointmentTitle,
                                 .lines = 0,
                                 ._font = [UIFont systemFontOfSize:14.0f],
                                 .color = [UIColor hx_colorWithHexString:@"282828"],
                                 .alignment = NSTextAlignmentLeft
                             }
                                                     NodeSpecs:
                             {
                                 .flexShrink = 0,
                                 .backgroundColor = [UIColor redColor],
                                 .marginLeft = flexLength(10, FlexLengthTypeDefault),
                                 .marginTop = flexLength(10, FlexLengthTypeDefault),
                                 .marginRight = flexLength(10, FlexLengthTypeDefault),
                                 .marginBottom = flexLength(10, FlexLengthTypeDefault)
                             }
                             ];
    return [titleNode computeLayoutThatFits:self.frame.size];
}

-(VZFLineNode *)lineNode
{
    VZFLineNode *lineNode = [VZFLineNode newWithLineAttributes:
    {
        .color = [UIColor redColor],
        .dashLength = 100,
        .spaceLength = 20
        
    }
                                                     NodeSpecs:
    {
        
    }];
    return lineNode;
}

-(NSString *)titleDataItem:(MShopAppointmentDataItem *)dataItem
{
    return [NSString stringWithFormat:@"%@预约了%@",dataItem.individualName,dataItem.type];
}

@end
