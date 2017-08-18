//
//  MShopMemberDetailViewController.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"
#import "MShopMemberListFreshDelegate.h"

@class MShopIndividualInfo;
@interface MShopMemberDetailViewController : MMViewController

@property (nonatomic,strong) MShopIndividualInfo *individual;
@property (nonatomic,strong) NSString *individualId;
@property (nonatomic,weak) id<MShopMemberListFreshDelegate> m_delegate;

@end
