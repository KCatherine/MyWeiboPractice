//
//  UIBarButtonItem+Extension.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barItemWithTarget:(nullable id)target action:(nullable SEL)action image:(nonnull NSString *)image highlightedImage:(nonnull NSString *)highlightedImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
