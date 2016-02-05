//
//  YJTitleButton.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJTitleButton.h"

@implementation YJTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}
/**
 *  重写setTitle:forState:方法，改变title时重设button的size
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}
/**
 *  重写setImage:forState:方法，改变title时重设button的size
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

@end
