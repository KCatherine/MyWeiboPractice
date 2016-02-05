//
//  UIBarButtonItem+Extension.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  快速创建一个自定义BarButtonItem
 *
 *  @param target           绑定按钮事件监听者
 *  @param action           监听者所做操作
 *  @param image            普通状态下的图片
 *  @param highlightedImage 高亮状态下的图片
 *
 *  @return 返回创建好的BarButtonItem
 */
+ (UIBarButtonItem *)barItemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

@end
