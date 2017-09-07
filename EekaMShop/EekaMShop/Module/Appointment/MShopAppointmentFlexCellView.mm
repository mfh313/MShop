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

@interface MShopAppointmentFlexCellView ()
{
    UIView *m_contentView;
}

@end

@implementation MShopAppointmentFlexCellView

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    self.backgroundColor = [UIColor lightGrayColor];
    
    [m_contentView removeFromSuperview];
    NodeLayout layout = [self stackNodeLayoutForAppointmentDataItem:dataItem];
    m_contentView = viewForRootNode(layout, self.bounds.size);
    m_contentView.frame = self.bounds;
    [self addSubview:m_contentView];
}

-(NodeLayout)stackNodeLayoutForAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    NSString *title = [NSString stringWithFormat:@"【%@】",dataItem.type];
    NSString *individualTitle = [NSString stringWithFormat:@"%@ %@",dataItem.individualName,dataItem.individualPhone];
    NSString *time = [NSString stringWithFormat:@"服务时间：%@ %@",dataItem.appointmentDate,dataItem.appointmentTime];
    NSString *appointmentNo = [NSString stringWithFormat:@"预约单号：%@",dataItem.appointmentNo];
    
    VZFStackNode *stackNode = [VZFStackNode newWithStackAttributes:{
        .wrap = VZFlexNoWrap,
        .direction = VZFlexVertical,
        .justifyContent = VZFlexStart,
        .alignItems = VZFlexStart,
        .alignContent = VZFlexStretch,
    }
                                                         NodeSpecs:
                               {
                                   .backgroundColor = [UIColor yellowColor],
                               }
                                                          Children:
                               {
                                   {
                                       [self textNodeForTitle:title textColor:[UIColor hx_colorWithHexString:@"282828"]]
                                   },
                                   {
                                       [self textNodeForTitle:individualTitle textColor:[UIColor hx_colorWithHexString:@"686868"]]
                                   },
                                   {
                                       [self textNodeForTitle:time textColor:[UIColor hx_colorWithHexString:@"686868"]]
                                   },
                                   {
                                       [self textNodeForTitle:appointmentNo textColor:[UIColor hx_colorWithHexString:@"686868"]]
                                   },
                                   {
                                       [self lineNode]
                                   }
                               }];
    
    return [stackNode computeLayoutThatFits:self.frame.size];
}

-(VZFTextNode *)textNodeForTitle:(NSString *)title textColor:(UIColor *)textColor
{
    VZFTextNode *titleNode = [VZFTextNode newWithTextAttributes:
                             {
                                 .text = title,
                                 .lines = 0,
                                 ._font = [UIFont systemFontOfSize:14.0f],
                                 .color = textColor,
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
    return titleNode;
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


@end
