//
//  MFTableViewUserInfo.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/27.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFTableViewUserInfo : NSObject
{
    NSMutableDictionary *_dicInfo;
    id _userInfo;
}

@property (nonatomic,strong) id userInfo;

-(void)addUserInfoValue:(id)value forKey:(NSString *)key;
-(id)getUserInfoValueForKey:(NSString *)key;

@end
