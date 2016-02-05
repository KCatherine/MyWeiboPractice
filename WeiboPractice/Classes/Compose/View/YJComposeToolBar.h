//
//  YJComposeToolBar.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJComposeToolBtnType) {
    YJComposeToolBtnTypeCamera,
    YJComposeToolBtnTypePhoto,
    YJComposeToolBtnTypeMention,
    YJComposeToolBtnTypeTrend,
    YJComposeToolBtnTypeEmotion
};

@class YJComposeToolBar;

@protocol YJComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(YJComposeToolBar *)toolBar didClickButton:(YJComposeToolBtnType)index;

@end

@interface YJComposeToolBar : UIView

@property (nonatomic, weak) id<YJComposeToolBarDelegate> delegate;
/**
 *  重构ToolBar时使用此变量进行emotion按钮的(键盘图标/表情图标)更换
 */
@property (nonatomic, assign) BOOL showKeyBoardButton;

+ (instancetype)composeToolBar;

@end
