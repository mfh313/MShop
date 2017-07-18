//
//  MMUIView.m
//  YJCustom
//
//  Created by EEKA on 16/9/22.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUIView.h"

@implementation MMUIView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (id)viewWithNibName:(NSString *)nibName
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    
    NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
    UIView *view = [nibObjects objectAtIndex:0];
    
    return view;
}


@end
