//
//  YJTextPart.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/6.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJTextPart.h"

@implementation YJTextPart

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end
