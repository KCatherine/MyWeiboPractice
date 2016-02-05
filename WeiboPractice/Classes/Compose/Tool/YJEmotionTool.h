//
//  YJEmotionTool.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJEmotion;

@interface YJEmotionTool : NSObject
/**
 *  储存表情到<最近>数组
 *
 *  @param oneEmotion 选中的表情
 */
+ (void)saveEmotion:(YJEmotion *)oneEmotion;
/**
 *  读取<最近>表情数组
 *
 *  @return 返回读取到的<最近>表情
 */
+ (NSArray *)loadRecentEmotions;

@end
