//
//  YJEmotionAttachment.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJEmotion;

@interface YJEmotionAttachment : NSTextAttachment
/**
 *  传入的表情模型
 */
@property (nonatomic, strong) YJEmotion *oneEmotion;

@end
