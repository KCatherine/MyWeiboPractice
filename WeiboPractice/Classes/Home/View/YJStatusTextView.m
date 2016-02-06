//
//  YJStatusTextView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusTextView.h"
#import "YJSpecial.h"

@implementation YJStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        //禁止滚动让文字处理
        self.scrollEnabled = NO;
//        self.selectable = NO;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint selectedPoint = [touch locationInView:self];
//    
//    NSArray *array = [self.attributedText attribute:YJSpecialKey atIndex:0 effectiveRange:NULL];
//    for (YJSpecial *special in array) {
//        //selectedRange影响selectedTextRange
//        self.selectedRange = special.range;
//        //获得选中范围的矩形框
//        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
//        //回复选中范围为0
//        self.selectedRange = NSMakeRange(0, 0);
//        for (UITextSelectionRect *selectionRect in rects) {
//            CGRect oneRect = selectionRect.rect;
//            if (oneRect.size.width == 0 || oneRect.size.height == 0) continue;
//            if (CGRectContainsPoint(oneRect, selectedPoint)) {
//                //取出原本的属性文字
//                NSMutableAttributedString *attrStr = [self.attributedText mutableCopy];
//                NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//                attrDict[NSForegroundColorAttributeName] = [UIColor redColor];
//                [attrStr addAttributes:attrDict range:special.range];
//                //将修改后的文字赋值回去
//                self.attributedText = attrStr;
//                return;
//            }
//        }
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//}

@end
