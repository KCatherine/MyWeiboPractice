//
//  NSDate+Extension.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  计算是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今天
 */
- (BOOL)isToday;

@end
