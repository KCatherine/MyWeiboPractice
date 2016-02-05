//
//  YJPlaceHolderTextView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJPlaceHolderTextView.h"

@interface YJPlaceHolderTextView ()
/**
 *  占位符文字
 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation YJPlaceHolderTextView

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        self.placeHolderColor = [UIColor lightGrayColor];
        [self setUpPlaceHolderLabel];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpPlaceHolderLabel {
    
    UILabel *placeHolder = [[UILabel alloc] init];
    self.label = placeHolder;
    
    [self addSubview:self.label];
}
//使用Quartz2D画出占位符
//- (void)drawRect:(CGRect)rect {
//    //有文字直接返回，不画占位文字
//    if (self.hasText) return;
//    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.font;
//    attrs[NSForegroundColorAttributeName] = self.placeHolderColor;
//    
//    CGFloat placeHolderX = 6;
//    CGFloat placeHolderY = 8;
//    CGFloat placeHolderW = rect.size.width - 2 * placeHolderX;
//    CGFloat placeHolderH = rect.size.height - 2 * placeHolderY;
//    CGRect placeHolderRect = CGRectMake(placeHolderX, placeHolderY, placeHolderW, placeHolderH);
//    
//    [self.placeHolder drawInRect:placeHolderRect withAttributes:attrs];
//}

- (void)layoutSubviews {
    
    self.label.hidden = self.hasText;
    
    if (self.label.hidden) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHolderColor;
    
    self.label.attributedText = [[NSAttributedString alloc] initWithString:self.placeHolder attributes:attrs];
    
    CGFloat placeHolderX = 6;
    CGFloat placeHolderY = 8;
    CGSize placeHolderSize = [self.label.text sizeWithFont:self.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect placeHolderRect = CGRectMake(placeHolderX, placeHolderY, placeHolderSize.width, placeHolderSize.height);
    
    self.label.frame = placeHolderRect;
    
}

- (void)textDidChange {
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

@end
