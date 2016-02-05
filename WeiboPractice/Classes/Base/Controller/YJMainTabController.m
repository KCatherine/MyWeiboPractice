//
//  YJMainTabController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJMainTabController.h"
#import "YJHomeViewController.h"
#import "YJMessageViewController.h"
#import "YJDiscoverViewController.h"
#import "YJProfileViewController.h"
#import "YJBaseNaviController.h"
#import "YJComposeViewController.h"
#import "YJMainTab.h"

@interface YJMainTabController ()<YJMainTabDelegate>

@end

@implementation YJMainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJMainTab *tabBar = [[YJMainTab alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    YJHomeViewController *vc1 = [[YJHomeViewController alloc] init];
    [self addchildVC:vc1 withTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    YJMessageViewController *vc2 = [[YJMessageViewController alloc] init];
    [self addchildVC:vc2 withTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    YJDiscoverViewController *vc3 = [[YJDiscoverViewController alloc] init];
    [self addchildVC:vc3 withTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    YJProfileViewController *vc4 = [[YJProfileViewController alloc] init];
    [self addchildVC:vc4 withTitle:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)addchildVC:(UIViewController *)childVC withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    YJBaseNaviController *nav = [[YJBaseNaviController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBarDidClickedAddButton:(YJMainTab *)tabBar {
    YJComposeViewController *compose = [[YJComposeViewController alloc] init];
    YJBaseNaviController *vc = [[YJBaseNaviController alloc] initWithRootViewController:compose];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
