//
//  YJTextPart.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJTextPart : NSObject
/**
 *  文字块的文字
 */
@property (nonatomic, copy) NSString *text;
/**
 *  文字块的位置
 */
@property (nonatomic, assign) NSRange range;
/**
 *  是否为特殊字符
 */
@property (nonatomic, assign, getter=isSpecial) BOOL special;
/**
 *  是否为表情
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
