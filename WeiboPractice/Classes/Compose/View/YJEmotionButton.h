//
//  YJEmotionButton.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJEmotion;

@interface YJEmotionButton : UIButton
/**
 *  传入一个表情模型
 */
@property (nonatomic, strong) YJEmotion *oneEmotion;

@end
