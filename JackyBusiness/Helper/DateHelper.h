//
//  DateHelper.h
//  YSBBusiness
//
//  Created by lu lucas on 20/12/14.
//  Copyright (c) 2014 lu lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DateHelper : NSObject

+ (NSString *)timeWithDate:(NSDate *)date;

+ (NSString *)yearWithDate:(NSDate *)date;
+ (NSString *)monthWithDate:(NSDate *)date;
+ (NSString *)weekWithDate:(NSString *)date;

/**
 *  将秒数转换为时：分：秒
 *
 *  @param duration <#duration description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)changeDurationToTime:(CGFloat)duration;

@end
