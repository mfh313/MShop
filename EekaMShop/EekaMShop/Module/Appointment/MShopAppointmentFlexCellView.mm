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
#import <vector>

using namespace VZ;
using namespace std;

@interface MShopAppointmentFlexCellView ()
{
    UIView *m_contentView;
}

@end

@implementation MShopAppointmentFlexCellView

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    self.backgroundColor = [UIColor redColor];
    NSLog(@"self.frame=%@",NSStringFromCGRect(self.frame));
    
    [m_contentView removeFromSuperview];
    NodeLayout layout = [self stackNodeLayoutForAppointmentDataItem:dataItem];
    m_contentView = viewForRootNode(layout, self.frame.size);
    m_contentView.frame = self.frame;
    [self addSubview:m_contentView];
}

-(NodeLayout)stackNodeLayoutForAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    NSString *title = [NSString stringWithFormat:@"[%@] %@",dataItem.typeValue,dataItem.appointmentNo];
    NSString *individualTitle = [NSString stringWithFormat:@"%@ %@",dataItem.individualName,dataItem.individualPhone];
    NSString *time = [NSString stringWithFormat:@"服务时间：%@ %@",dataItem.appointmentDate,dataItem.appointmentTime];
    
    UIColor *blackColor = [UIColor hx_colorWithHexString:@"282828"];
    UIColor *lightGrayColor = [UIColor hx_colorWithHexString:@"989898"];
    
    vector<VZFStackChildNode> children;
    children.push_back({
        [self textNodeForTitle:title textColor:blackColor font:[UIFont systemFontOfSize:14.0f]]
    });
    children.push_back({
        [self textNodeForTitle:individualTitle textColor:blackColor]
    });
    children.push_back({
        [self textNodeForTitle:time textColor:blackColor]
    });
    
    if ([dataItem.status isEqualToString:MShopAppointmentStatusHandled])
    {
        NSString *score = nil;
        if (dataItem.score)
        {
            score = [NSString stringWithFormat:@"评分：%@",dataItem.score];
            children.push_back({
                [self textNodeForTitle:score textColor:blackColor]
            });
        }
        else
        {
            score = [NSString stringWithFormat:@"已完成服务,顾客未评分"];
            children.push_back({
                [self textNodeForTitle:score textColor:lightGrayColor]
            });
        }
        
        NSString *evaluate = nil;
        if (dataItem.evaluate)
        {
            evaluate = [NSString stringWithFormat:@"详细评价：%@",dataItem.evaluate];
            children.push_back({
                [self textNodeForTitle:evaluate textColor:blackColor]
            });
        }
        else
        {
            evaluate = [NSString stringWithFormat:@"已完成服务,顾客未填写评价"];
            children.push_back({
                [self textNodeForTitle:evaluate textColor:lightGrayColor]
            });
        }
    }
    else
    {
        NSString *statusText;
        if ([dataItem.status isEqualToString:MShopAppointmentStatusInvalidate]) {
            statusText = @"该预约已作废";
        }
        else if ([dataItem.status isEqualToString:MShopAppointmentStatusConfirmed])
        {
            statusText = @"已确认";
        }
        else if ([dataItem.status isEqualToString:MShopAppointmentStatusPending])
        {
            statusText = @"待处理";
        }
        
        children.push_back({
            [self textNodeForTitle:statusText textColor:lightGrayColor]
        });
    }
    
    children.push_back({
        [self lineNode]
    });
    
    VZFStackNode *stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
        .wrap = VZFlexNoWrap,
        .justifyContent = VZFlexSpaceAround,
        .alignItems = VZFlexStart,
        .alignContent = VZFlexSpaceAround,
    }
                                                         NodeSpecs:
                               {
                                   .backgroundColor = [UIColor whiteColor],
                                   .flexShrink = 0,
                               }
                                                          Children:children];
    
    return [stackNode computeLayoutThatFits:self.frame.size];
}

-(VZFTextNode *)textNodeForTitle:(NSString *)title textColor:(UIColor *)textColor
{
    return [self textNodeForTitle:title textColor:textColor font:[UIFont systemFontOfSize:14.0f]];
}

-(VZFTextNode *)textNodeForTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font
{
    VZFTextNode *titleNode = [VZFTextNode newWithTextAttributes:
                              {
                                  .text = title,
                                  .lines = 0,
                                  ._font = font,
                                  .color = textColor,
                                  .alignment = NSTextAlignmentLeft
                              }
                                                      NodeSpecs:
                              {
                                  .flexShrink = 0,
                                  .backgroundColor = [UIColor clearColor],
                                  .marginLeft = flexLength(10, FlexLengthTypeDefault),
                                  .marginTop = flexLength(10, FlexLengthTypeDefault),
                                  .marginRight = flexLength(10, FlexLengthTypeDefault),
                                  .marginBottom = FlexLengthZero
                              }
                              ];
    return titleNode;
}

-(VZFLineNode *)lineNode
{
    VZFLineNode *lineNode = [VZFLineNode newWithLineAttributes:
    {
        .color = MFCustomLineColor,
        
    }
                                                     NodeSpecs:
    {
        .width = flexLength(CGRectGetWidth(self.bounds), FlexLengthTypeDefault),
        .height = MFOnePixHeight,
        .marginTop = FlexLengthAuto,
        .marginBottom = FlexLengthZero,
    }];
    return lineNode;
}


@end
