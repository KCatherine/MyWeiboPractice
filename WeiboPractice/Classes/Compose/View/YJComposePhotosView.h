//
//  YJComposePhotosView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJComposePhotosView : UIView
/**
 *  向配图中添加一张图片
 *
 *  @param image 要添加的图片
 */
- (void)addPhoto:(UIImage *)image;
/**
 *  所添加的全部图片
 */
@property (nonatomic, strong, readonly) NSMutableArray *photos;

@end
