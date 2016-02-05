//
//  YJEmotionTextView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionTextView.h"
#import "YJEmotion.h"
#import "YJEmotionAttachment.h"

@implementation YJEmotionTextView

- (void)insertEmotion:(YJEmotion *)oneEmotion {
    if (oneEmotion.code) {
        [self insertText:oneEmotion.code.emoji];
    } else if (oneEmotion.png) {
        //属性文字的附件
        YJEmotionAttachment *attachment = [[YJEmotionAttachment alloc] init];
        //传递表情模型
        attachment.oneEmotion = oneEmotion;
        //取出原先textView中的行高,并将attachment设置为原先的位置和大小
        CGFloat attachWH = self.font.lineHeight;
        attachment.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [self insertAttributedText:imgStr settingBlock:^(NSMutableAttributedString *attributedText) {
            //将之前文本框中的字体属性保存给现在的属性文字使用
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}

- (NSString *)fullText {
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        YJEmotionAttachment *attach = attrs[@"NSAttachment"];
        
        if (attach) {
            [fullText appendString:attach.oneEmotion.chs];
        } else {
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}

@end
