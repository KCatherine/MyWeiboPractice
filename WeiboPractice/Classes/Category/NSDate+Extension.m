//
//  NSDate+Extension.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * createComps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents * nowComps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return createComps.year == nowComps.year;
}

- (BOOL)isYesterday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSString *nowStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSDate *now = [dateFormatter dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * resultComps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return resultComps.year == 0 && resultComps.month == 0 && resultComps.day == 1;
}

- (BOOL)isToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSString *nowStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

@end
