//
//  YJEmotion.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotion.h"

#import "MJExtension.h"

@interface YJEmotion ()<NSCoding>

@end

@implementation YJEmotion

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}
/**
 *  重写isEqual方法来移除相同表情
 */
- (BOOL)isEqual:(YJEmotion *)object {
    return [self.png isEqualToString:object.png] || [self.code isEqualToString:object.code];
}

@end
