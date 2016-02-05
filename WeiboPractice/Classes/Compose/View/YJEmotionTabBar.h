//
//  YJEmotionTabBar.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJEmotionTabBarButtonType) {
    YJEmotionTabBarButtonTypeRecent,
    YJEmotionTabBarButtonTypeDefault,
    YJEmotionTabBarButtonTypeEmoji,
    YJEmotionTabBarButtonTypeLXH
};

@class YJEmotionTabBar;

@protocol YJEmotionTabBarDelegate <NSObject>
@optional
- (void)emontionTabBar:(YJEmotionTabBar *)tabBar didSelectButton:(YJEmotionTabBarButtonType)buttonType;

@end

@interface YJEmotionTabBar : UIView

@property (nonatomic, weak) id<YJEmotionTabBarDelegate> delegate;

@end
