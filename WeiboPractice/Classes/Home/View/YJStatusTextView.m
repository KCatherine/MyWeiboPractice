//
//  YJStatusTextView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusTextView.h"
#import "YJSpecial.h"

#define CoverTag 999

@implementation YJStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        //禁止滚动让文字处理
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint selectedPoint = [touch locationInView:self];
    
    NSArray *array = [self.attributedText attribute:YJSpecialKey atIndex:0 effectiveRange:NULL];
    BOOL contains = NO;
    
    for (YJSpecial *special in array) {
        //selectedRange影响selectedTextRange
        self.selectedRange = special.range;
        //获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        //恢复选中范围为0
        self.selectedRange = NSMakeRange(0, 0);
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect oneRect = selectionRect.rect;
            if (oneRect.size.width == 0 || oneRect.size.height == 0) continue;
            if (CGRectContainsPoint(oneRect, selectedPoint)) {
                contains = YES;
                break;
            }
        }
        
        if (contains) {
            for (UITextSelectionRect *selectionRect in rects) {
                CGRect oneRect = selectionRect.rect;
                if (oneRect.size.width == 0 || oneRect.size.height == 0) continue;
                
                UIView *tmp = [[UIView alloc] init];
                tmp.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.25];
                tmp.frame = oneRect;
                tmp.layer.cornerRadius = 5;
                tmp.tag = CoverTag;
                [self insertSubview:tmp atIndex:0];
            }
            break;
        }
    }
    NSLog(@"touchesbegan---");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (view.tag == CoverTag) {
            [view removeFromSuperview];
        }
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSArray *array = [self.attributedText attribute:YJSpecialKey atIndex:0 effectiveRange:NULL];
    BOOL contains = NO;
    for (YJSpecial *special in array) {
        //selectedRange影响selectedTextRange
        self.selectedRange = special.range;
        //获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        //恢复选中范围为0
        self.selectedRange = NSMakeRange(0, 0);
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect oneRect = selectionRect.rect;
            if (oneRect.size.width == 0 || oneRect.size.height == 0) continue;
            if (CGRectContainsPoint(oneRect, point)) {
                contains = YES;
                break;
            }
        }
        if (contains) {
            break;
        }
    }
    return contains;
}

@end
