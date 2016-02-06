//
//  YJEmotionTool.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionTool.h"
#import "YJEmotion.h"

#import "MJExtension.h"

#define RECENT_LOC [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent.archive"]

@implementation YJEmotionTool
/**
 *  全局变量储存<最近>表情数组
 */
static NSMutableArray *_recentEmotions;
/**
 *  全局变量储存<默认>表情数组
 */
static NSMutableArray *_defaultEmotions;
/**
 *  全局变量储存<浪小花>表情数组
 */
static NSMutableArray *_lxhEmotions;
/**
 *  全局变量储存<emoji>表情数组
 */
static NSMutableArray *_emojiEmotions;
/**
 *  所有存储的表情
 */
static NSMutableArray *_allEmotions;
/**
 *  初始化数组
 */
+ (void)initialize {
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:RECENT_LOC];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
    
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultInfo" ofType:@"plist"];
        _defaultEmotions = [YJEmotion mj_objectArrayWithFile:path];
    }
    
    if (_lxhEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxhInfo" ofType:@"plist"];
        _lxhEmotions = [YJEmotion mj_objectArrayWithFile:path];
    }
    
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emojiInfo" ofType:@"plist"];
        _emojiEmotions = [YJEmotion mj_objectArrayWithFile:path];
    }
    
    if (_allEmotions == nil) {
        _allEmotions = [NSMutableArray array];
        [_allEmotions addObjectsFromArray:_defaultEmotions];
        [_allEmotions addObjectsFromArray:_lxhEmotions];
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

+ (NSArray *)defaultEmotions {
    return _defaultEmotions;
}

+ (NSArray *)lxhEmotions {
    return _lxhEmotions;
}

+ (NSArray *)emojiEmotions {
    return _emojiEmotions;
}

+ (YJEmotion *)emotionWithCHS:(NSString *)chs {
    for (YJEmotion *oneEmotion in _allEmotions) {
        if ([chs isEqualToString:oneEmotion.chs]) {
            return oneEmotion;
        }
    }
    return nil;
}

@end
