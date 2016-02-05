//
//  YJEmotionTabBar.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionTabBar.h"
#import "YJEmotionTabBarButton.h"

#define EMO_TAB_BUTTON_COUNT 4

@interface YJEmotionTabBar ()

@property (nonatomic, weak) YJEmotionTabBarButton *selectedBtn;

@end

@implementation YJEmotionTabBar
/**
 *  重写delegate的setter让默认按钮进行点击,因为在初始化时delegate为nil
 */
- (void)setDelegate:(id<YJEmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    
    [self btnClick:[self viewWithTag:YJEmotionTabBarButtonTypeDefault]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBtn:@"最近" type:YJEmotionTabBarButtonTypeRecent];
        
        [self setUpBtn:@"默认" type:YJEmotionTabBarButtonTypeDefault];
        
        [self setUpBtn:@"Emoji" type:YJEmotionTabBarButtonTypeEmoji];
        
        [self setUpBtn:@"浪小花" type:YJEmotionTabBarButtonTypeLXH];
    }
    return self;
}

- (YJEmotionTabBarButton *)setUpBtn:(NSString *)title type:(YJEmotionTabBarButtonType)buttonType {
    YJEmotionTabBarButton *btn = [[YJEmotionTabBarButton alloc] init];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    
    if (buttonType == YJEmotionTabBarButtonTypeDefault) {
        [self btnClick:btn];
    }
    
    if (self.subviews.count == 1) {
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateDisabled];
    } else if (self.subviews.count == EMO_TAB_BUTTON_COUNT) {
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_selected"] forState:UIControlStateDisabled];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateDisabled];
    }
    
    [self addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        YJEmotionTabBarButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(YJEmotionTabBarButton *)btn {
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emontionTabBar:didSelectButton:)]) {
        [self.delegate emontionTabBar:self didSelectButton:btn.tag];
    }
}

@end
