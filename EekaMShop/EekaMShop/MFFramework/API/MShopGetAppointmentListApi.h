//
//  MShopGetAppointmentListApi.h
//  EekaMShop
//
//  Created by EEKA on 2017/8/3.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface MShopGetAppointmentListApi : MFNetworkRequest
{
    NSInteger _pageIndex;
    NSInteger _pageSize;
    BOOL _usePaging;
}

-(void)setPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
