//
//  MShopGetConsumptionItems.h
//  EekaMShop
//
//  Created by EEKA on 2017/7/28.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopGetConsumptionItems : MFNetworkRequest
{
    NSInteger _pageIndex;
    NSInteger _pageSize;
    BOOL _usePaging;
}

@property (nonatomic,strong) NSString *individualId;

-(void)setPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
