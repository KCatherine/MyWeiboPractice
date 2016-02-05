//
//  UIView+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  view的frame.origin.x
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  view的frame.origin.y
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  view的center.x
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  view的center.y
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  view的frame.size.width
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  view的frame.size.height
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  view的frame.size
 */
@property (nonatomic, assign) CGSize size;
/**
 *  view的frame.origin
 */
@property (nonatomic, assign) CGPoint origin;

@end
