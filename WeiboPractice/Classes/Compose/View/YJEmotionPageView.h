//
//  YJEmotionPageView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COL_MAX 7
#define ROW_MAX 3
#define EMOTION_PER_PAGE ((COL_MAX * ROW_MAX) - 1)

@interface YJEmotionPageView : UIView
/**
 *  单页表情数组
 */
@property (nonatomic, strong) NSArray *onePageEmotions;

@end
