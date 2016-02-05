//
//  YJUserModel.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJUserModel.h"

@implementation YJUserModel
/**
 *  重写mbtype的setter计算VIP属性
 */
- (void)setMbtype:(NSInteger)mbtype {
    _mbtype = mbtype;
    self.vip = (mbtype > 2);
}

@end
