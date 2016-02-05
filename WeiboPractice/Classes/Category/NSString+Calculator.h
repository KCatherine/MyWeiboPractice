//
//  NSString+Calculator.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Calculator)
/**
 *  依据文字字体和最大宽高计算文字的CGSize
 *
 *  @param font    文字的字体
 *  @param maxSize 文字整体的最大CGSize
 *
 *  @return 计算好的CGSize
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
