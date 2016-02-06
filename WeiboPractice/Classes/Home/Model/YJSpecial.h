//
//  YJSpecial.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJSpecial : NSObject
/**
 *  特殊文字块的文字
 */
@property (nonatomic, copy) NSString *text;
/**
 *  特殊文字块的位置
 */
@property (nonatomic, assign) NSRange range;

@end
