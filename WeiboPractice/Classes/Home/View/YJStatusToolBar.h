//
//  YJStatusToolBar.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJStatusToolBarButtonType) {
    YJStatusToolBarButtonTypeRepost,
    YJStatusToolBarButtonTypeComment,
    YJStatusToolBarButtonTypeGood
};

@class YJStatusModel;
@class YJStatusToolBar;

@protocol YJStatusToolBarDelegate <NSObject>

@optional
- (void)statusToolBar:(YJStatusToolBar *)toolBar DidClickButton:(YJStatusToolBarButtonType)type;

@end

@interface YJStatusToolBar : UIView
/**
 *  传入的微博模型
 */
@property (nonatomic, strong) YJStatusModel *oneStatus;

@property (nonatomic, weak) id<YJStatusToolBarDelegate> delegate;

+ (instancetype)statusToolBar;

@end
