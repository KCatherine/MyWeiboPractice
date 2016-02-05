//
//  YJEmotionTabBarButton.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionTabBarButton.h"

@implementation YJEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
/**
 *  重写setHighlighted方法忽略高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
