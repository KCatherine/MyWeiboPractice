//
//  UITextView+Extension.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
/**
 *  插入属性文字到当前TextView中
 *
 *  @param attributedString 要插入的属性文字
 */
- (void)insertAttributedText:(NSAttributedString *)attributedString;
/**
 *  插入属性文字到当前TextView中
 *
 *  @param attributedString 要插入的属性文字
 *  @param settingBlock   需要额外修改的文字
 */
- (void)insertAttributedText:(NSAttributedString *)attributedString settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
