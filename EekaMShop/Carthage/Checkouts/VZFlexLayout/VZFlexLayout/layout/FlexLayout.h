//
//  FlexLayout.h
//  flex_layout
//
//  Created by Sleen on 16/1/25.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#pragma once

#ifdef __cplusplus
extern "C"{
#endif

#include <stddef.h>
#ifndef __cplusplus
#   include <stdbool.h>
#endif

typedef enum {
    FlexHorizontal,
    FlexVertical,
    FlexHorizontalReverse,
    FlexVerticalReverse
} FlexDirection;

static const FlexDirection FLEX_WIDTH = FlexHorizontal;
static const FlexDirection FLEX_HEIGHT = FlexVertical;

typedef enum {
    FlexNoWrap,
    FlexWrap,
    FlexWrapReverse,
} FlexWrapMode;

typedef enum {
    FlexInherit,
    FlexStretch,
    FlexStart,
    FlexCenter,
    FlexEnd,
    FlexSpaceBetween,
    FlexSpaceAround,
    FlexBaseline,
} FlexAlign;

typedef struct {
    float size[2];
} FlexSize;

typedef enum {
    FLEX_LEFT = 0,
    FLEX_TOP,
    FLEX_RIGHT,
    FLEX_BOTTOM,
    FLEX_START,
    FLEX_END
} FlexPositionIndex;

typedef struct {
    float position[2];
    float size[2];
    float margin[4];
    float border[4];
} FlexResult;

typedef enum {
    FlexLengthTypeDefault,
    FlexLengthTypePercent,
    FlexLengthTypePx,
    FlexLengthTypeCm,       // 1cm = 96px/2.54
    FlexLengthTypeMm,       // 1mm = 1/10th of 1cm
    FlexLengthTypeQ,        // 1q = 1/40th of 1cm
    FlexLengthTypeIn,       // 1in = 2.54cm = 96px
    FlexLengthTypePc,       // 1pc = 1/6th of 1in
    FlexLengthTypePt,       // 1pt = 1/72th of 1in
    FlexLengthTypeEm,       // font size of element
//    FlexLengthTypeEx,       // x-height of the element’s font
//    FlexLengthTypeCh,       // width of the "0" (ZERO, U+0030) glyph in the element’s font
//    FlexLengthTypeRem,      // font size of the root element
    FlexLengthTypeVw,       // 1% of viewport’s width
    FlexLengthTypeVh,       // 1% viewport’s height
    FlexLengthTypeVmin,     // 1% of viewport’s smaller dimension
    FlexLengthTypeVmax      // 1% of viewport’s larger dimension
} FlexLengthType;

typedef struct {
    float value;
    FlexLengthType type;
} FlexLength;

inline FlexLength flexLength(float value, FlexLengthType type) {
    FlexLength r;
    r.value = value;
    r.type = type;
    return r;
}

extern const float FlexAuto;
extern const float FlexUndefined;
extern const float FlexContent;

#define FlexLengthZero      flexLength(0, FlexLengthTypeDefault)
#define FlexLengthAuto      flexLength(FlexAuto, FlexLengthTypeDefault)
#define FlexLengthContent   flexLength(FlexContent, FlexLengthTypeDefault)
#define FlexLengthUndefined flexLength(FlexUndefined, FlexLengthTypeDefault)

typedef struct FlexNode {
    FlexWrapMode wrap;
    FlexDirection direction;
    FlexAlign alignItems;
    FlexAlign alignSelf;
    FlexAlign alignContent;
    FlexAlign justifyContent;
    FlexLength flexBasis;       // length, percentage(relative to the flex container's inner main size), auto, content
    float flexGrow;
    float flexShrink;
    FlexLength size[2];         // length, percentage(relative to the flex container's inner size), auto
    FlexLength minSize[2];      // length, percentage(relative to the flex container's inner size)
    FlexLength maxSize[2];      // length, percentage(relative to the flex container's inner size), none
    FlexLength margin[6];       // length, percentage(relative to the flex container's inner width), auto
    FlexLength padding[6];      // length, percentage(relative to the flex container's inner width)
    FlexLength border[6];       // length
    
    // extension
    bool fixed;
    FlexLength spacing;         // the spacing between each two items. length, percentage(relative to its inner main size)
    FlexLength lineSpacing;     // the spacing between each two lines. length, percentage(relative to its inner cross size)
    unsigned int lines;         // the maximum number of lines, 0 means no limit
    unsigned int itemsPerLine;  // the maximum number of items per line, 0 means no limit
    
    FlexResult result;
    
    // internal fields
    float flexBaseSize;
    float resolvedMargin[4];
    float resolvedPadding[4];
    float ascender;
    
    // cache measure results
    void* measuredSizeCache;
    
    void* context;
    size_t childrenCount;
    FlexSize (*measure)(void* context, FlexSize constrainedSize);
    float (*baseline)(void* context, FlexSize constrainedSize);
    struct FlexNode* (*childAt)(void* context, size_t index);
} FlexNode;

FlexNode* newFlexNode();
void initFlexNode(FlexNode* node);
void freeFlexNode(FlexNode* node);
void layoutFlexNode(FlexNode* node, float constrainedWidth, float constrainedHeight, float scale);

#ifdef __cplusplus
}
#endif
