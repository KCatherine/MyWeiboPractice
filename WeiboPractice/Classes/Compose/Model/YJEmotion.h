//
//  YJEmotion.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJEmotion : NSObject
/**
 *  表情的文字描述
 */
@property (nonatomic, copy) NSString *chs;
/**
 *  表情的图片名
 */
@property (nonatomic, copy) NSString *png;
/**
 *  (仅同于emoji)emoji的16进制编码
 */
@property (nonatomic, copy) NSString *code;

@end
