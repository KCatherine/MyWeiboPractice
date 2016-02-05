//
//  YJIconView.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJUserModel;

@interface YJIconView : UIImageView
/**
 *  传入的用户模型
 */
@property (nonatomic, strong) YJUserModel *oneUser;

@end
