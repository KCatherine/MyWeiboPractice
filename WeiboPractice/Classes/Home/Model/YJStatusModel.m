//
//  YJStatusModel.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

NSString * const YJTopicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
NSString * const YJUserPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
NSString * const YJURLPattern = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?:(?:/[a-zA-Z0-9\\-._?,’+\\&%$=~*!():@\\\\]*)+)?";
NSString * const YJEmotionPattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";

#import "YJStatusModel.h"
#import "YJUserModel.h"
#import "YJStatusPhoto.h"
#import "YJTextPart.h"
#import "YJSpecial.h"
#import "YJEmotionTool.h"
#import "YJEmotion.h"

#import "MJExtension.h"
#import "RegexKitLite.h"

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

- (void)setText:(NSString *)text {
    _text = [text copy];
    
    NSMutableAttributedString *attrStr = [self attributedTextWithText:text];

    //设置正文的字体
    [attrStr addAttribute:NSFontAttributeName value:TextFont range:NSMakeRange(0, attrStr.length)];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:YJ_COLOR(51, 51, 51) range:NSMakeRange(0, attrStr.length)];
    
    self.attributedText = attrStr;
}

- (void)setRetweeted_status:(YJStatusModel *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = nil;
    if (retweeted_status.user) {
        retweetContent = [NSString stringWithFormat:@"@%@:%@", retweeted_status.user.name, retweeted_status.text];
    } else {
        retweetContent = [NSString stringWithFormat:@"%@", retweeted_status.text];
    }
    
    NSMutableAttributedString *attrStr = [self attributedTextWithText:retweetContent];

    //设置转发微博的字体
    [attrStr addAttribute:NSFontAttributeName value:ReTweetTextFont range:NSMakeRange(0, attrStr.length)];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:YJ_COLOR(93, 93, 93) range:NSMakeRange(0, attrStr.length)];
    
    self.retweetedAttributedText = attrStr;
}

/**
 *  将微博内容转换为关键字特殊颜色的属性文字
 *
 *  @param text 传入的普通文字
 *
 *  @return 转换好的属性文字
 */
- (NSMutableAttributedString *)attributedTextWithText:(NSString *)text {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableArray *parts = [NSMutableArray array];
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", YJTopicPattern, YJUserPattern, YJURLPattern, YJEmotionPattern];
    //取出所有特殊字符串,添加到parts数组中
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        YJTextPart *part = [[YJTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        part.special = YES;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        [parts addObject:part];
    }];
    //取出所有非特殊字符串,添加到parts数组中
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        YJTextPart *part = [[YJTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        part.special = NO;
        [parts addObject:part];
    }];
    //排列parts数组中的字符串,得到正常顺序的字符串
    [parts sortUsingComparator:^NSComparisonResult(YJTextPart * _Nonnull part1, YJTextPart * _Nonnull part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    //依次取出特殊字符串进行转换
    NSMutableArray *specials = [NSMutableArray array];
    for (YJTextPart *part in parts) {
        NSAttributedString *subStr = nil;
        if (part.isEmotion) {
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            NSString *name = [YJEmotionTool emotionWithCHS:part.text].png;
            if (name) {
                attach.image = [UIImage imageNamed:name];
                attach.bounds = CGRectMake(0, -4, 16, 16);
                subStr = [NSAttributedString attributedStringWithAttachment:attach];
            } else {
                subStr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.isSpecial) {
            subStr = [[NSAttributedString alloc] initWithString:part.text
                                                     attributes:@{NSForegroundColorAttributeName : YJ_COLOR(82, 126, 173)}];
            //将特殊字符保存成对象方便在TextView中调用
            YJSpecial *special = [[YJSpecial alloc] init];
            special.text = part.text;
            NSUInteger loc = attrStr.length;
            NSUInteger len = part.text.length;
            special.range = NSMakeRange(loc, len);
            [specials addObject:special];
        } else {
            subStr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attrStr appendAttributedString:subStr];
    }
    
    [attrStr addAttribute:YJSpecialKey value:specials range:NSMakeRange(0, 1)];
    
    return attrStr;
}

@end
