//
//  MMUITextField.h
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMUITextField : UITextField
{
    BOOL m_bRestrictShareMenu;
    double m_fPlaceholderFontSize;
}

@property (nonatomic,assign) BOOL m_bRestrictShareMenu;
@property (nonatomic,assign) double m_fPlaceholderFontSize;
    
@end
