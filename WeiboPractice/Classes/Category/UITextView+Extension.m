//
//  UITextView+Extension.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)attributedString {
    [self insertAttributedText:attributedString settingBlock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)attributedString settingBlock:(void (^)(NSMutableAttributedString *))settingBlock {
    //使用属性文字保存之前输入的内容
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:self.attributedText];
    
    NSUInteger loc = self.selectedRange.location;
    //替换属性文字到光标处,若没有选中则插入到光标处
    [attrStr replaceCharactersInRange:self.selectedRange withAttributedString:attributedString];
    
    if (settingBlock) {
        settingBlock(attrStr);
    }
    
    self.attributedText = attrStr;
    //移动光标到插入的下一个地点
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

@end
