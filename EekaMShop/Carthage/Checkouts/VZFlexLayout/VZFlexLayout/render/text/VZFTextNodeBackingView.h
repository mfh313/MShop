//
//  VZFTextNodeBackingView.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeBackingViewInterface.h"
#import "VZFTextNodeBackingLayer.h"
#import "VZFBackingViewProtocol.h"

@class VZFTextNodeRenderer;
@interface VZFTextNodeBackingView : UIView<VZFNodeBackingViewInterface, VZFBackingViewProtocol>

@property(nonatomic,strong) VZFTextNodeRenderer* textRenderer;
@property(nonatomic,assign) UIEdgeInsets edgeInsets;

@end
