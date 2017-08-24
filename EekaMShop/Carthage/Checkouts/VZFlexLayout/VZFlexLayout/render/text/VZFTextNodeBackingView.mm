//
//  VZFTextNodeBackingView.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNodeBackingView.h"
#import "VZFTextNodeBackingLayer.h"
#import "VZFTextNodeRenderer.h"
#import "VZFUtils.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFTextNodeInternal.h"

@implementation VZFTextNodeBackingView

+ (Class)layerClass{
        return [VZFTextNodeBackingLayer class];
}

- (VZFTextNodeBackingLayer* )textLayer{
    return (VZFTextNodeBackingLayer* )self.layer;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set some sensible defaults for a text view
        self.contentScaleFactor = VZ::Helper::screenScale();
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTextRenderer:(VZFTextNodeRenderer *)textRenderer{
    
    [self textLayer].renderer  = textRenderer;
}

- (VZFTextNodeRenderer* )textRenderer{
    return [self textLayer].renderer;
}

- (__kindof VZFRenderer *)renderer {
    return [self textRenderer];
}

- (void)setRenderer:(__kindof VZFRenderer *)renderer {
    if ([renderer isKindOfClass:[VZFTextNodeRenderer class]]) {
        [self textLayer].renderer = (VZFTextNodeRenderer *)renderer;
    } else {
        [self textLayer].renderer = nil;
    }
}

- (void)setCachePolicy:(VZFRasterizeCachePolicy)cachePolicy {
    self.textLayer.rasterizeCachePolicy = cachePolicy;
}


-(void)setLayerNeedsAsyncDisplay{
    [self.textLayer setNeedsAsyncDisplay];
}


- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    [self textLayer].edgeInsets = edgeInsets;
}

- (UIEdgeInsets)edgeInsets {
    return [self textLayer].edgeInsets;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (![self.backgroundColor isEqual:backgroundColor]) {
        BOOL opaque = self.textLayer.opaque;
        [super setBackgroundColor:backgroundColor];
        
        // for reasons I don't understand, UIView is setting opaque=NO on self.layer when setting the background color.  we
        // don't want to force our rich text layers to draw with blending, so check if we can keep the opacity value after
        // setting the backgroundColor.
        if (opaque) {
            CGFloat alpha = 0.0;
            if ([backgroundColor getRed:NULL green:NULL blue:NULL alpha:&alpha] ||
                [backgroundColor getWhite:NULL alpha:&alpha] ||
                [backgroundColor getHue:NULL saturation:NULL brightness:NULL alpha:&alpha]) {
                if (alpha == 1.0) {
                    self.textLayer.opaque = YES;
                }
            }
        }
    }
}

// 用于 Accessibility
- (NSString *)text {
    return self.textRenderer.text.string;
}

- (void)setText:(NSString *)text {
    NSAttributedString *oldText = self.textRenderer.text;
    if (!text) {
        self.textRenderer.text = nil;
    }
    else if (oldText.length == 0) {
        self.textRenderer.text = [[NSAttributedString alloc] initWithString:text];
    }
    else {
        self.textRenderer.text = [[NSAttributedString alloc] initWithString:text attributes:[oldText attributesAtIndex:0 effectiveRange:nil]];
    }
    [self setNeedsDisplay];
}

- (NSAttributedString *)attributedText {
    return self.textRenderer.text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    self.textRenderer.text = attributedText;
    [self setNeedsDisplay];
}

-(void)drawTextInRect:(CGRect)rect{
    
}

- (BOOL)isAccessibilityElement {
    if ([self renderer]) {
        return [[self renderer] checkIsAccessibilityElement];
    }
    return [super isAccessibilityElement];
}

- (NSString *)accessibilityLabel {
    if ([self renderer]) {
        return [[self renderer] compositeAccessibilityLabel];
    }
    return [super accessibilityLabel];
}

- (void)vz_applyNodeAttributes:(VZFTextNode *)textNode{
    TextNodeSpecs textNodeSpecs =textNode.textSpecs;
    self.textRenderer = textNode.renderer;
    self.edgeInsets = textNode.flexNode.resultPadding;
    [self textLayer].displayMode = kDisplayModeSync;//text node不会有子结点，暂时一定同步绘制
}

@end
