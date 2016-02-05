//
//  YJEmotionTextView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJPlaceHolderTextView.h"

@class YJEmotion;

@interface YJEmotionTextView : YJPlaceHolderTextView
/**
 *  插入表情
 */
- (void)insertEmotion:(YJEmotion *)oneEmotion;

- (NSString *)fullText;

@end
