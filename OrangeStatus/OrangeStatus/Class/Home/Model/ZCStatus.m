//
//  ZCStatus.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatus.h"
#import "ZCUser.h"
#import "MJExtension.h"
#import "ZCPhoto.h"


@implementation ZCStatus
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [ZCPhoto class]};
}


- (NSString *)created_at
{
    
    // _created_at == Thu Oct 16 17:06:25 +0800 2014
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy
    
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 微博的创建日期
    NSDate *createDate = [formatter dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:now options:0];
    //获得某个时间的年月日时分秒
//    NSDateComponents *createDateComponents = [calendar components:unit fromDate:createDate];
    
    
    if ([createDate isThisYear]) {
        
        if ([createDate isYesterday]) {
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
        }else if([createDate isToday]){
            if (components.hour > 1) {
                return [NSString stringWithFormat:@"%ld小时前", components.hour];
                
            }else if(components.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前", components.minute];
            }else{
                return @"刚刚";
            }
        }else{
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
        
    }else{
        formatter.dateFormat = @"yyyy-MM-dd";
        
        return [formatter stringFromDate:createDate];
    
    
    }

    
}


- (void)setSource:(NSString *)source
{
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    
    
}

@end
