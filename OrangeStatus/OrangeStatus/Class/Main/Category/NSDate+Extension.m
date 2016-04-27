//
//  NSDate+Extension.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/27.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获得某个时间的年月日时分秒
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return components.year == nowComponents.year;
    
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    
    NSString *dateString = [formatter stringFromDate:self];
    
    NSString *nowString = [formatter stringFromDate:now];
    
    
    NSDate *date = [[NSDate alloc] init];
    date = [formatter dateFromString:dateString];
    now = [formatter dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 计算两个日期之间的差值
    NSDateComponents *components = [calendar components:unit fromDate:date toDate:now options:0];
    
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    
    NSString *dateString = [formatter stringFromDate:self];
    
    NSString *nowString = [formatter stringFromDate:now];
    
    return [dateString isEqualToString:nowString];
}





@end
