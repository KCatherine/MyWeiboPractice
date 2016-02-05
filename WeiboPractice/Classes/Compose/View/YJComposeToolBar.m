//
//  YJComposeToolBar.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJComposeToolBar.h"

@interface YJComposeToolBar ()

@property (nonatomic, weak) UIButton *emotionBtn;

@end

@implementation YJComposeToolBar

- (void)setShowKeyBoardButton:(BOOL)showKeyBoardButton {
    _showKeyBoardButton = showKeyBoardButton;
    
    if (showKeyBoardButton) {
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

+ (instancetype)composeToolBar {
    return [[YJComposeToolBar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setUpBtnWithImage:@"compose_camerabutton_background" highlightedImage:@"compose_camerabutton_background_highlighted" typ:YJComposeToolBtnTypeCamera];
        [self setUpBtnWithImage:@"compose_toolbar_picture" highlightedImage:@"compose_toolbar_picture_highlighted" typ:YJComposeToolBtnTypePhoto];
        [self setUpBtnWithImage:@"compose_mentionbutton_background" highlightedImage:@"compose_mentionbutton_background_highlighted" typ:YJComposeToolBtnTypeMention];
        [self setUpBtnWithImage:@"compose_trendbutton_background" highlightedImage:@"compose_trendbutton_background_highlighted" typ:YJComposeToolBtnTypeTrend];
        self.emotionBtn = [self setUpBtnWithImage:@"compose_emoticonbutton_background" highlightedImage:@"compose_emoticonbutton_background_highlighted" typ:YJComposeToolBtnTypeEmotion];
    }
    return self;
}

- (UIButton *)setUpBtnWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage typ:(YJComposeToolBtnType)type {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:btn.tag];
    }
}

@end
