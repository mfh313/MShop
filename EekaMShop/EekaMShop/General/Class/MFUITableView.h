//
//  MFUITableView.h
//  BloomBeauty
//
//  Created by Administrator on 15/12/8.
//  Copyright © 2015年 EEKA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tableViewDelegate <NSObject>

@optional
- (void)didFinishedLoading:(id)arg1;
- (void)touchesBegan_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event;
- (void)touchesCancelled_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event;
- (void)touchesEnded_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event;
- (void)touchesMoved_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event;
@end

@interface MFUITableView : UITableView

@property (nonatomic,weak) id<tableViewDelegate> m_delegate;

@end
