//
//  YJMainTab.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJMainTab;

@protocol YJMainTabDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickedAddButton:(YJMainTab *)tabBar;

@end

@interface YJMainTab : UITabBar

@property (nonatomic, weak) id<YJMainTabDelegate, UITabBarDelegate> delegate;

@end
