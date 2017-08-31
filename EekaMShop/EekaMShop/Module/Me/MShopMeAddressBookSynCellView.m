//
//  MShopMeAddressBookSynCellView.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopMeAddressBookSynCellView.h"

@interface MShopMeAddressBookSynCellView ()
{
    __weak IBOutlet UILabel *_synProgressLabel;
}

@end

@implementation MShopMeAddressBookSynCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _synProgressLabel.hidden = NO;
    _synProgressLabel.text = @"正在同步";
}

-(void)setSynProgressLabel:(NSString *)text hidden:(BOOL)hidden
{
    _synProgressLabel.hidden = hidden;
    _synProgressLabel.text = text;
}

@end
