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
    self.backgroundColor = [UIColor clearColor];
    
    NSLog(@"self.frame=%@",NSStringFromCGRect(self.frame));
    
    [m_contentView removeFromSuperview];
    NodeLayout layout = [self stackNodeLayoutForAppointmentDataItem:dataItem];
    m_contentView = viewForRootNode(layout, self.frame.size);
    m_contentView.frame = self.frame;
    [self addSubview:m_contentView];
}

-(NodeLayout)stackNodeLayoutForAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    NSString *title = [NSString stringWithFormat:@"[%@]",dataItem.type];
    NSString *individualTitle = [NSString stringWithFormat:@"%@ %@",dataItem.individualName,dataItem.individualPhone];
    NSString *time = [NSString stringWithFormat:@"服务时间：%@ %@",dataItem.appointmentDate,dataItem.appointmentTime];
    
    vector<VZFStackChildNode> children;
    children.push_back({
        [self textNodeForTitle:title textColor:[UIColor hx_colorWithHexString:@"282828"]]
    });
    children.push_back({
        [self textNodeForTitle:individualTitle textColor:[UIColor hx_colorWithHexString:@"282828"]]
    });
    children.push_back({
        [self textNodeForTitle:time textColor:[UIColor hx_colorWithHexString:@"282828"]]
    });
    
//    if ([dataItem.status isEqualToString:MShopAppointmentStatusHandled])
    if (self.indexPath.row % 2 == 1)
    {
        children.push_back({
            [self textNodeForTitle:@"评分：5" textColor:[UIColor hx_colorWithHexString:@"282828"]]
        });
        children.push_back({
            [self textNodeForTitle:@"详细评价：美好的评价。。。。" textColor:[UIColor hx_colorWithHexString:@"282828"]]
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
