//
//  YJEmotionAttachment.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionAttachment.h"
#import "YJEmotion.h"

@implementation YJEmotionAttachment

- (void)setOneEmotion:(YJEmotion *)oneEmotion {
    _oneEmotion = oneEmotion;
    
    self.image = [UIImage imageNamed:oneEmotion.png];
}

@end
