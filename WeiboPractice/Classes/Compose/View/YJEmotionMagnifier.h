//
//  YJEmotionMagnifier.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJEmotionButton;

@interface YJEmotionMagnifier : UIView

+ (instancetype)emotionMagnifier;

- (void)showFrom:(YJEmotionButton *)button;

@end
