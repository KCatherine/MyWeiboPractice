//
//  YJEmotionKeyBoard.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionKeyBoard.h"
#import "YJEmotionListView.h"
#import "YJEmotionTabBar.h"
#import "YJEmotion.h"
#import "YJEmotionTool.h"

#import "MJExtension.h"

@interface YJEmotionKeyBoard ()<YJEmotionTabBarDelegate>
/**
 *  显示<最近>表情的视图
 */
@property (nonatomic, strong) YJEmotionListView *recentListView;
/**
 *  显示<默认>表情的视图
 */
@property (nonatomic, strong) YJEmotionListView *defaultListView;
/**
 *  显示<emoji>表情的视图
 */
@property (nonatomic, strong) YJEmotionListView *emojiListView;
/**
 *  显示<浪小花>表情的视图
 */
@property (nonatomic, strong) YJEmotionListView *lxhListView;
/**
 *  容纳表情的视图
 */
@property (nonatomic, weak) UIView *contentView;
/**
 *  底部切换表情的tabbar
 */
@property (nonatomic, weak) YJEmotionTabBar *tabBar;

@end

@implementation YJEmotionKeyBoard

- (YJEmotionListView *)recentListView {
    if (!_recentListView) {
        _recentListView = [[YJEmotionListView alloc] init];
    }
    return _recentListView;
}

- (YJEmotionListView *)defaultListView {
    if (!_defaultListView) {
        _defaultListView = [[YJEmotionListView alloc] init];
        _defaultListView.emotions = [YJEmotionTool defaultEmotions];

    }
    return _defaultListView;
}

- (YJEmotionListView *)emojiListView {
    if (!_emojiListView) {
        _emojiListView = [[YJEmotionListView alloc] init];
        _emojiListView.emotions = [YJEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (YJEmotionListView *)lxhListView {
    if (!_lxhListView) {
        _lxhListView = [[YJEmotionListView alloc] init];
        _lxhListView.emotions = [YJEmotionTool lxhEmotions];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *contentView = [[UIView alloc] init];
        self.contentView = contentView;
        [self addSubview:contentView];
        
        YJEmotionTabBar *tabBar = [[YJEmotionTabBar alloc] init];
        tabBar.delegate = self;
        self.tabBar = tabBar;
        [self addSubview:tabBar];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectEmotion) name:YJEmotionDidSelectNotification object:nil];
    }
    return self;
}
         
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tabBar.height = 37;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.height = self.tabBar.y;
    self.contentView.width = self.width;
    
    YJEmotionListView *child = [[self.contentView subviews] lastObject];
    child.frame = self.contentView.bounds;
}

- (void)didSelectEmotion {
    self.recentListView.emotions = [YJEmotionTool loadRecentEmotions];
}

#pragma mark - emotionTabBar代理协议
- (void)emontionTabBar:(YJEmotionTabBar *)tabBar didSelectButton:(YJEmotionTabBarButtonType)buttonType {
    //移除contentView中的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //根据按钮类型设置表情控件
    switch (buttonType) {
        case YJEmotionTabBarButtonTypeRecent: {
            [self.contentView addSubview:self.recentListView];
            self.recentListView.emotions = [YJEmotionTool loadRecentEmotions];
            break;
        }
            
        case YJEmotionTabBarButtonTypeDefault: {
            [self.contentView addSubview:self.defaultListView];
            break;
        }
            
        case YJEmotionTabBarButtonTypeEmoji: {
            [self.contentView addSubview:self.emojiListView];
            break;
        }
            
        case YJEmotionTabBarButtonTypeLXH: {
            [self.contentView addSubview:self.lxhListView];
            break;
        }
    }
    
    [self setNeedsLayout];
}

@end
