//
//  YJSearchBar.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJSearchBar.h"

@implementation YJSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置侧边图像
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode = UIViewContentModeCenter;
        //设置搜索条背景
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc] init];
}

@end
