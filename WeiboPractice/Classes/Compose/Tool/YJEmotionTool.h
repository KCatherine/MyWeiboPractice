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
 */
+ (NSArray *)loadRecentEmotions;
/**
 *  读取<默认>表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  读取<emoji>表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  读取<浪小花>表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  根据文字描述获取表情数组
 *
 *  @param chs 传入的文字描述
 *
 *  @return 返回的表情
 */
+ (YJEmotion *)emotionWithCHS:(NSString *)chs;

@end
