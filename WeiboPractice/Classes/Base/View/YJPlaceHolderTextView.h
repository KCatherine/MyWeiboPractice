//
//  YJPlaceHolderTextView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJPlaceHolderTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeHolder;
/**
 *  占位文字颜色，默认为亮灰色
 */
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
