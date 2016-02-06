//
//  YJSpecial.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJSpecial.h"

@implementation YJSpecial

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end
