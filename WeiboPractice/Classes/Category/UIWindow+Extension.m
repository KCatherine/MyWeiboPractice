//
//  UIWindow+Extension.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "YJMainTabController.h"
#import "YJNewFeatureController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController {
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        YJMainTabController *tabbarVC = [[YJMainTabController alloc] init];
        self.rootViewController = tabbarVC;
    } else {
        YJNewFeatureController *featureVC = [[YJNewFeatureController alloc] init];
        self.rootViewController = featureVC;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
