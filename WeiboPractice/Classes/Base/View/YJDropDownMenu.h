//
//  YJDropDownMenu.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJDropDownMenu;

@protocol YJDropDownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDidShow:(YJDropDownMenu *)dropDownMenu;
- (void)dropDownMenuDidDisMiss:(YJDropDownMenu *)dropDownMenu;

@end

@interface YJDropDownMenu : UIView

@property (nonatomic, weak) id<YJDropDownMenuDelegate> delegate;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *contetViewController;

+ (instancetype)menu;

- (void)showFrom:(UIView *)from;
- (void)dismiss;

@end
