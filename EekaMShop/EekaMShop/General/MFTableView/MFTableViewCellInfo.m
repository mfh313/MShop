//
//  MFTableViewCellInfo.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/27.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewCellInfo.h"

@implementation MFTableViewCellInfo

- (instancetype)init
{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.editStyle = UITableViewCellEditingStyleNone;
        self.autoCorrectionType = UITextAutocorrectionTypeYes;
        self.cellStyle = UITableViewCellStyleValue1;
    }
    return self;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:sel target:target title:title accessoryType:accessoryType isFitIpadClassic:NO];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:accessoryType isFitIpadClassic:isFitIpadClassic];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:accessoryType isFitIpadClassic:NO];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue imageName:nil accessoryType:accessoryType isFitIpadClassic:isFitIpadClassic];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue imageName:imageName accessoryType:accessoryType isFitIpadClassic:NO];
    return cellInfo;
}

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [[MFTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeNormalCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTarget:target];
    [cellInfo setFCellHeight:44.0f];
    [cellInfo setAccessoryType:accessoryType];
    [cellInfo setIsNeedFixIpadClassic:isFitIpadClassic];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:rightValue forKey:@"rightValue"];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForSel:nil target:nil title:title rightValue:rightValue accessoryType:0];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cellInfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForTitle:title rightValue:rightValue];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForTitle:title rightValue:rightValue imageName:imageName];
    [cellInfo setIsNeedFixIpadClassic:isFitIpadClassic];
    return nil;
}

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [MFTableViewCellInfo normalCellForTitle:title rightValue:rightValue imageName:nil isFitIpadClassic:isFitIpadClassic];
    return cellInfo;
}

- (void)makeNormalCell:(MFTableViewCellInfo *)cellInfo title:(NSString *)title
{
    [self addUserInfoValue:title forKey:@"title"];
    [self makeNormalCell:cellInfo];
}

- (void)makeNormalCell:(MFTableViewCellInfo *)cellInfo
{
//    NSString *title = [self getUserInfoValueForKey:@"title"];
//    UIColor *titleColor = [self getUserInfoValueForKey:@"titleColor"];
//    UIFont *titleFont = [self getUserInfoValueForKey:@"titleFont"];
//    NSString *detail = [self getUserInfoValueForKey:@"detail"];
//    UIColor *detailColor = [self getUserInfoValueForKey:@"detailColor"];
//    UIFont *detailFont = [self getUserInfoValueForKey:@"detailFont"];
//    NSString *rightValue = [self getUserInfoValueForKey:@"rightValue"];
//    UIColor *rightValueColor = [self getUserInfoValueForKey:@"rightValueColor"];
//    NSString *leftValue = [self getUserInfoValueForKey:@"leftValue"];
//    UIColor *leftValueColor = [self getUserInfoValueForKey:@"leftValueColor"];
//    NSString *imageName = [self getUserInfoValueForKey:@"imageName"];
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget calHeightSel:(SEL)calHeightSel calHeightTarget:(id)calHeightTarget userInfo:(MFTableViewUserInfo *)userInfo
{
    MFTableViewCellInfo *cellInfo = [[MFTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.calHeightSel = calHeightSel;
    cellInfo.calHeightTarget = calHeightTarget;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(MFTableViewUserInfo *)userInfo
{
    MFTableViewCellInfo *cellInfo = [[MFTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.fCellHeight = height;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(MFTableViewUserInfo *)userInfo isFitIpadClassic:(BOOL)isFitIpadClassic
{
    MFTableViewCellInfo *cellInfo = [[MFTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.fCellHeight = height;
    cellInfo.userInfo = userInfo;
    cellInfo.isNeedFixIpadClassic = isFitIpadClassic;
    return cellInfo;
}

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget height:(CGFloat)height userInfo:(MFTableViewUserInfo *)userInfo
{
    MFTableViewCellInfo *cellInfo = [[MFTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.fCellHeight = height;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}

@end
