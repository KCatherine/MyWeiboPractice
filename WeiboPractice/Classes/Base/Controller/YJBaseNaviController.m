//
//  YJBaseNaviController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJBaseNaviController.h"

@interface YJBaseNaviController ()

@end

@implementation YJBaseNaviController

+ (void)initialize {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *textDisableAttrs = [NSMutableDictionary dictionary];
    textDisableAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.7];
    textDisableAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    
    [item setTitleTextAttributes:textDisableAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backBtn = [UIBarButtonItem barItemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.leftBarButtonItem = backBtn;

        UIBarButtonItem *moreBtn = [UIBarButtonItem barItemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
        viewController.navigationItem.rightBarButtonItem = moreBtn;
    }
    
#warning first call [super pushViewController: animated:] to push the first viewcontroller
    [super pushViewController:viewController animated:YES];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end
