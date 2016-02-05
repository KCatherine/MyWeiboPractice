//
//  YJStatusPhotosView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJStatusPhotosView : UIView
/**
 *  配图数组
 */
@property (nonatomic, strong) NSArray *photosArray;
/**
 *  计算PhotosView的size
 */
+ (CGSize)sizeWithCount:(NSInteger)count;

@end
