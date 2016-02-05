//
//  YJMainTab.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJMainTab.h"

@interface YJMainTab ()
/**
 *  tabbar上的发微博按钮
 */
@property (nonatomic, weak) UIButton *addBtn;

@end

@implementation YJMainTab

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.size = addBtn.currentBackgroundImage.size;
        [self addSubview:addBtn];
        self.addBtn = addBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.addBtn.centerX = self.width * 0.5;
    self.addBtn.centerY = self.height * 0.5;
    
    CGFloat tabbarbuttonW = self.width / 5;
    CGFloat tabbarbuttonIndex = 0;
    for (NSInteger i = 0; i < 5; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarbuttonW;
            child.x = tabbarbuttonIndex * tabbarbuttonW;
            tabbarbuttonIndex++;
            if (tabbarbuttonIndex == 2) {
                tabbarbuttonIndex++;
            }
        }
    }
}

- (void)addBtnClick {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedAddButton:)]) {
        [self.delegate tabBarDidClickedAddButton:self];
    }
}

@end
