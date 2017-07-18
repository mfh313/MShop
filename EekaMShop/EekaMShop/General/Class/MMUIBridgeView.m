//
//  MMUIBridgeView.m
//  YJCustom
//
//  Created by EEKA on 16/9/23.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "XXNibBridge.h"

@interface MMUIBridgeView () <XXNibBridge>

@end

@implementation MMUIBridgeView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (id)nibView
{
    NSString *nibName = NSStringFromClass(self);
    return [self viewWithNibName:nibName];
}

+ (id)viewWithNibName:(NSString *)nibName
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    
    NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
    UIView *view = [nibObjects objectAtIndex:0];
    
    return view;
}

@end
