//
//  YJEmotionButton.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionButton.h"
#import "YJEmotion.h"

@implementation YJEmotionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setOneEmotion:(YJEmotion *)oneEmotion {
    _oneEmotion = oneEmotion;
    
    if (oneEmotion.png) {
        [self setImage:[UIImage imageNamed:oneEmotion.png] forState:UIControlStateNormal];
    } else if (oneEmotion.code) {
        [self setTitle:oneEmotion.code.emoji forState:UIControlStateNormal];
    }
}

- (void)setUp {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}

@end
