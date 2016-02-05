//
//  YJEmotionTool.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionTool.h"
#import "YJEmotion.h"

#define RECENT_LOC [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent.archive"]

@implementation YJEmotionTool
/**
 *  全局变量储存<最近>表情数组
 */
static NSMutableArray *_recentEmotions;
/**
 *  初始化数组
 */
+ (void)initialize {
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:RECENT_LOC];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)saveEmotion:(YJEmotion *)oneEmotion {
    
    [_recentEmotions removeObject:oneEmotion];
    
    [_recentEmotions insertObject:oneEmotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:RECENT_LOC];
}

+ (NSArray *)loadRecentEmotions {
    return _recentEmotions;
}

@end
