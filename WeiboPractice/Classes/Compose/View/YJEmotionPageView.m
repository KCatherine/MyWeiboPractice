//
//  YJEmotionPageView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionPageView.h"
#import "YJEmotion.h"
#import "YJEmotionMagnifier.h"
#import "YJEmotionButton.h"
#import "YJEmotionTool.h"

#define INSET 10

@interface YJEmotionPageView ()
/**
 *  图片放大镜
 */
@property (nonatomic, strong) YJEmotionMagnifier *magnifier;
/**
 *  删除按钮
 */
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation YJEmotionPageView

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteBtn = deleteBtn;
        [self addSubview:deleteBtn];
    }
    return _deleteBtn;
}

- (YJEmotionMagnifier *)magnifier {
    if (!_magnifier) {
        _magnifier = [YJEmotionMagnifier emotionMagnifier];
    }
    return _magnifier;
}

- (void)setOnePageEmotions:(NSArray *)onePageEmotions {
    _onePageEmotions = onePageEmotions;
    
    for (NSUInteger i = 0; i < onePageEmotions.count; i++) {
        
        YJEmotionButton *emotionBtn = [[YJEmotionButton alloc] init];
        emotionBtn.oneEmotion = onePageEmotions[i];
        
        [emotionBtn addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:emotionBtn];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = (self.width - INSET * 2) / COL_MAX;
    //底部没有间距
    CGFloat btnH = (self.height - INSET) / ROW_MAX;
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        //self.subviews[0]为删除按钮
        UIButton *emotionBtn = self.subviews[i];
        emotionBtn.width = btnW;
        emotionBtn.height = btnH;
        emotionBtn.x = INSET + (i % COL_MAX) * btnW;
        emotionBtn.y = INSET + (i / COL_MAX) * btnH;
    }
    
    //设置删除按钮的尺寸和位置
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width - INSET - btnW;
    //因为底部没有间距,所以Y值这样算
    self.deleteBtn.y = self.height - btnH;
    
}

- (void)emotionButtonClick:(YJEmotionButton *)btn {
    [self.magnifier showFrom:btn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.magnifier removeFromSuperview];
    });
    
    [self sendEmotionDidSelectNotification:btn.oneEmotion];
}

- (void)deleteBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:YJTextWillDeleteNotification object:nil];
}

- (void)sendEmotionDidSelectNotification:(YJEmotion *)oneEmotion {
    //将表情存入『最近』数组
    [YJEmotionTool saveEmotion:oneEmotion];
    
    //发出选中表情的通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[YJSelectedEmotion] = oneEmotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:YJEmotionDidSelectNotification object:nil userInfo:userInfo];
}

- (YJEmotionButton *)emotionButtonWithLocation:(CGPoint)location {
    NSUInteger count = self.onePageEmotions.count;
    for (NSUInteger i = 0; i < count; i++) {
        YJEmotionButton *btn = self.subviews[i];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}

- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    YJEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
            //不再触摸屏幕
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            [self.magnifier removeFromSuperview];
            if (btn) {
                [self sendEmotionDidSelectNotification:btn.oneEmotion];
            }
            break;
        }
            
            //刚检测到长按
        case UIGestureRecognizerStateBegan:
            //长按并移动时
        case UIGestureRecognizerStateChanged: {
            [self.magnifier showFrom:btn];
            break;
        }
            
        default:
            break;
    }
}

@end
