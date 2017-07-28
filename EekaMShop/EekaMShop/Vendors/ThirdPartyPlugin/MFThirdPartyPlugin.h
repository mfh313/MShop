//
//  MFThirdPartyPlugin.h
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFThirdPartyPlugin : NSObject
    
-(void)registerPlugins;

-(void)applicationDidBecomeActive:(UIApplication *)application;

@end
