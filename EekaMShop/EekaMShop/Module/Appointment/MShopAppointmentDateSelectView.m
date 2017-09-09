//
//  MShopAppointmentDateSelectView.m
//  EekaMShop
//
//  Created by EEKA on 2017/9/8.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MShopAppointmentDateSelectView.h"
#import "MShopAppointmentDataItem.h"

@interface MShopAppointmentDateSelectView () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    __weak IBOutlet UIButton *_doneBtn;
    __weak IBOutlet UIDatePicker *m_datePicker;
    __weak IBOutlet UIPickerView *m_timePicker;
    __weak IBOutlet UIImageView *_bgImageView;
    
    NSMutableArray *_timeArray;
    
    MShopAppointmentDataItem *m_dataItem;
}

@end

@implementation MShopAppointmentDateSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.5];
    [_doneBtn setBackgroundImage:MFImageStretchCenter(@"bg_red") forState:UIControlStateNormal];
    _bgImageView.image = MFImageStretchCenter(@"round");
    
    m_datePicker.datePickerMode = UIDatePickerModeDate;
    m_datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    m_datePicker.minimumDate = [self dateByAddingYears:-1 date:[NSDate date]];
    m_datePicker.maximumDate = [self dateByAddingYears:1 date:[NSDate date]];
    
    m_timePicker.dataSource = self;
    m_timePicker.delegate = self;
}

- (NSDate *)dateByAddingYears:(NSInteger)dYears date:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

-(NSDate *)dateForAppointmentDate:(NSString *)appointmentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *date = [formatter dateFromString:appointmentDate];
    
    return date;
}

-(void)setAppointmentDataItem:(MShopAppointmentDataItem *)dataItem
{
    m_dataItem = dataItem;
    [self setAppointmentDate:m_dataItem.appointmentDate appointmentTime:m_dataItem.appointmentTime];
}

-(MShopAppointmentDataItem *)appointmentDataItem
{
    return m_dataItem;
}

-(void)setAppointmentDate:(NSString *)appointmentDate appointmentTime:(NSString *)appointmentTime
{
    NSDate *selectedDate = [self dateForAppointmentDate:appointmentDate];
    [m_datePicker setDate:selectedDate animated:NO];
    
    _timeArray = [self availableDateHours:[NSDate date]];
    [m_timePicker reloadAllComponents];
    NSInteger selectedTimeIndex = [_timeArray indexOfObject:appointmentTime];
    if (selectedTimeIndex == NSNotFound) {
        selectedTimeIndex = 0;
    }
    [m_timePicker selectRow:selectedTimeIndex inComponent:0 animated:NO];
}

-(NSMutableArray *)availableDateHours:(NSDate *)date
{
    return [NSMutableArray arrayWithArray:[self hoursArray]];
}

-(NSArray *)hoursArray
{
    return @[@"08:00-09:00",
             @"09:00-10:00",
             @"10:00-11:00",
             @"11:00-12:00",
             @"12:00-13:00",
             @"13:00-14:00",
             @"14:00-15:00",
             @"15:00-16:00",
             @"16:00-17:00",
             @"17:00-18:00",
             @"18:00-19:00",
             @"19:00-20:00",
             @"20:00-21:00",
             @"21:00-22:00",
             @"22:00-23:00"
             ];
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return CGRectGetWidth(pickerView.bounds);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _timeArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    if (view == nil) {
        CGFloat width = [self pickerView:pickerView widthForComponent:component];
        CGFloat height = [self pickerView:pickerView rowHeightForComponent:component];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
        
        return label;
    }
    
    return view;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = _timeArray[row];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title];
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, attString.string.length)];
    CFRelease(fontRef);
    
    return attString;
}

- (IBAction)onClickDoneButton:(id)sender
{
    [self removeFromSuperview];
    if ([self.m_delegate respondsToSelector:@selector(onClickDoneButton:)]) {
        [self.m_delegate onClickDoneButton:self];
    }
    
    NSString *seletedYearDate = [self seletedYearDate];
    NSInteger selectedIndex = [m_timePicker selectedRowInComponent:0];
    NSString *selectedTime = _timeArray[selectedIndex];
    
    if ([self.m_delegate respondsToSelector:@selector(didSetAppointmentDate:appointmentTime:selectView:)]) {
        [self.m_delegate didSetAppointmentDate:seletedYearDate appointmentTime:selectedTime selectView:self];
    }
}

- (IBAction)onClickBgView:(id)sender {
    [self removeFromSuperview];
}

-(NSString *)seletedYearDate
{
    NSDate *selectDate = m_datePicker.date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectDate];
    NSString *year = [NSString stringWithFormat:@"%2ld",(long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld",(long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld",(long)[components day]];
    
    NSString *dateDesc = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    
    return dateDesc;
}

@end
