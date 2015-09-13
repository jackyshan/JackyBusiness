//
//  DateHelper.m
//  YSBBusiness
//
//  Created by lu lucas on 20/12/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import "DateHelper.h"

static const NSDateFormatter *formatter = nil;

@implementation DateHelper

+ (void)initialize
{
    formatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)timeWithDate:(NSDate *)date
{
    return [formatter stringFromDate:date];
}

+ (NSString *)yearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    return @([dateComponent year]).stringValue;
}

+ (NSString *)monthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    return [NSString stringWithFormat:@"%02ld", (long)[dateComponent month]];
}

+ (NSString *)weekWithDate:(NSString *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekOfMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[formatter dateFromString:date]];
    
    return @([dateComponent weekOfMonth]).stringValue;
}


+ (NSString *)changeDurationToTime:(CGFloat)duration
{
    NSInteger time = ceilf(duration);
    NSString *hour = [NSString stringWithFormat:@"%02ld", time / 3600];
    NSString *min = [NSString stringWithFormat:@"%02ld", (time - [hour integerValue] * 3600) / 60];
    NSString *sec = [NSString stringWithFormat:@"%02ld", time - [hour integerValue] * 3600 - [min integerValue] * 60];
    return [NSString stringWithFormat:@"%@:%@:%@", hour, min, sec];
}

@end
