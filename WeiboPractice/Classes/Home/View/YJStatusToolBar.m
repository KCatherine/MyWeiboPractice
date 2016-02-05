//
//  YJStatusToolBar.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusToolBar.h"
#import "YJStatusModel.h"

#define TEN_THOUSAND 10000.0

@interface YJStatusToolBar ()

/**
 *  转发按钮
 */
@property (nonatomic, weak) UIButton *repostsBtn;
/**
 *  评论按钮
 */
@property (nonatomic, weak) UIButton *commentsBtn;
/**
 *  点赞按钮
 */
@property (nonatomic, weak) UIButton *attitudesBtn;

/**
 *  添加的按钮数组
 */
@property (nonatomic, strong) NSMutableArray *btns;
/**
 *  添加的分隔符数组
 */
@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation YJStatusToolBar

- (void)setOneStatus:(YJStatusModel *)oneStatus {
    _oneStatus = oneStatus;
    
    [self setBtnCount:oneStatus.reposts_count title:@"转发" button:self.repostsBtn];
    [self setBtnCount:oneStatus.comments_count title:@"评论" button:self.commentsBtn];
    [self setBtnCount:oneStatus.attitudes_count title:@"赞" button:self.attitudesBtn];
}
/**
 *  根据数据计算按钮的文字
 */
- (void)setBtnCount:(NSInteger)count title:(NSString *)title button:(UIButton *)btn {
    if (count) {
        if (count < TEN_THOUSAND) {
            title = [NSString stringWithFormat:@"%ld", count];
        } else {
            double num = count / TEN_THOUSAND;
            title = [NSString stringWithFormat:@"%.1f万", num];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers {
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)statusToolBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]]];
        
        self.repostsBtn = [self setUpBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentsBtn = [self setUpBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudesBtn = [self setUpBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        [self setUpDivider];
        [self setUpDivider];
        
    }
    return self;
}

- (UIButton *)setUpBtn:(NSString *)title icon:(NSString *)icon {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)setUpDivider {
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = self.height;
    }
    
    NSInteger dividerCount = self.dividers.count;
    for (NSInteger i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

@end
