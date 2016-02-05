//
//  YJDropDownMenu.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJDropDownMenu.h"

@interface YJDropDownMenu ()
/**
 *  弹出菜单的图片
 */
@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation YJDropDownMenu

- (UIImageView *)containerView {
    if (!_containerView) {
        UIImageView *contetView = [[UIImageView alloc] init];
        contetView.image = [UIImage imageNamed:@"popover_background"];
//        contetView.width = 217;
//        contetView.height = 217;
        contetView.userInteractionEnabled = YES;
        [self addSubview:contetView];
        self.containerView = contetView;
    }
    return _containerView;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    contentView.x = 10;
    contentView.y = 15;
    
    self.containerView.height = CGRectGetMaxY(contentView.frame) + contentView.x;
    
    self.containerView.width = CGRectGetMaxX(contentView.frame) + contentView.x;
    
    [self.containerView addSubview:contentView];
}

- (void)setContetViewController:(UIViewController *)contetViewController {
    _contetViewController = contetViewController;
    self.contentView = contetViewController.view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (instancetype)menu {
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)from {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    //转换坐标系，将控件坐标系转换为窗口
    CGRect newRect = [from.superview convertRect:from.frame toView:nil];
    
    self.containerView.centerX = CGRectGetMidX(newRect);
    self.containerView.y = CGRectGetMaxY(newRect);
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDisMiss:)]) {
        [self.delegate dropDownMenuDidDisMiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
