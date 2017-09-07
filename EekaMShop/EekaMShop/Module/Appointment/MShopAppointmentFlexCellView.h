//
//  MShopAppointmentFlexCellView.h
//  EekaMShop
//
//  Created by mafanghua on 2017/9/7.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MShopAppointmentDataItem;
@interface MShopAppointmentFlexCellView : UIView

@property (nonatomic,strong) NSIndexPath *indexPath;

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem;

@end
