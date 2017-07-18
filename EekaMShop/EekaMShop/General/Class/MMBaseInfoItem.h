//
//  MMBaseInfoItem.h
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMObject.h"

@class MMBaseInfoItem;

@protocol MMBaseInfoItemDelegate <NSObject>
    
@optional
- (void)MMBaseInfoItemBeginEdit:(MMBaseInfoItem *)infoItem;
- (void)MMBaseInfoItemCancelEdit:(MMBaseInfoItem *)infoItem;
- (void)MMBaseInfoItemEditChanged:(MMBaseInfoItem *)infoItem;
- (void)MMBaseInfoItemEndEdit:(MMBaseInfoItem *)infoItem;
- (void)MMBaseInfoItemPressReturnKey:(MMBaseInfoItem *)infoItem;
- (BOOL)MMBaseInfoItemShouldBeginEditing:(MMBaseInfoItem *)infoItem;
    
@end

@interface MMBaseInfoItem : MMObject
{
    NSString *m_title;
    NSString *m_tip;
    NSString *m_key;
    UIView *m_view;
    UIView *m_superView;
    BOOL m_bEnable;
    BOOL m_bActive;
    
    __weak id <MMBaseInfoItemDelegate> m_delegate;
}
    
@property (nonatomic,assign) BOOL m_bActive;
@property (nonatomic,assign) BOOL m_bEnable;
@property (nonatomic,strong) NSString *m_key;
@property (nonatomic,strong) NSString *m_tip;
@property (nonatomic,strong) NSString *m_title;
@property (nonatomic,strong) UIView *m_view;

- (void)becomeFirstResponder;
- (id)getValue;
- (void)initView:(CGRect)frame;
- (id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key;
- (void)resignFirstResponder;
- (void)setDelegate:(id)delegate;
- (void)setEnable:(BOOL)enable;
- (void)setSuperView:(UIView *)view;
    
@end
