//
//  YJStatusToolBar.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJStatusModel;

@interface YJStatusToolBar : UIView
/**
 *  传入的微博模型
 */
@property (nonatomic, strong) YJStatusModel *oneStatus;

+ (instancetype)statusToolBar;

@end
