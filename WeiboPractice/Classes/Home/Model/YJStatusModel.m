//
//  YJStatusModel.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusModel.h"
#import "YJUserModel.h"
#import "YJStatusPhoto.h"

#import "MJExtension.h"

@implementation YJStatusModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [YJStatusPhoto class]};
}

//重写getter实现实时计算创建时间和frame
//
//    1.今年
//        A.今天
//            a.1分钟内
//            刚刚
//            b.1分钟~59分钟内
//            mm分钟前
//            c.大于等于60分钟
//            HH小时前
//        B.昨天
//        昨天 HH:mm
//        C.其他
//        MM-dd HH:mm
//
//    2.非今年
//    yyyy-MM-dd
- (NSString *)created_at {
    //Tue Feb 02 13:24:40 +0800 2016
    //EEE MMM dd HH:mm:ss Z yyyy
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss ZZZZZ yyyy";
    
    NSDate *createDate = [dateFormatter dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * resultComps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) {
        if ([createDate isToday]) {
            if (resultComps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", resultComps.hour];
            } else if (resultComps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", resultComps.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createDate isYesterday]) {
            dateFormatter.dateFormat = @"昨天 HH:mm";
            return [dateFormatter stringFromDate:createDate];
        } else {
            dateFormatter.dateFormat = @"MM-dd HH:mm";
            return [dateFormatter stringFromDate:createDate];
        }
    } else {
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        return [dateFormatter stringFromDate:createDate];
    }
}

/**
 *  重写setter在加载时更改微博来源
 */
- (void)setSource:(NSString *)source {
    //<a href="http://app.weibo.com/t/feed/3G5oUM" rel="nofollow">iPhone 5s</a>
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
}

@end
