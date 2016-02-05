//
//  YJConst.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Key-选中的表情
 */
NSString * const YJSelectedEmotion = @"selectedEmotion";

/**
 *  选择了表情的通知
 */
NSString * const YJEmotionDidSelectNotification = @"YJEmotionDidSelectNotification";
/**
 *  即将删除文字的通知
 */
NSString * const YJTextWillDeleteNotification = @"YJTextWillDeleteNotification";

/**
 *  OAuth时使用的AppKey, 备用为 @"195317136"
 */
NSString * const YJAppKey = @"319238554";
/**
 *  OAuth时使用的AppSecret, 备用为 @"5637c564148b23aea29159d22737f79a"
 */
NSString * const YJAppSecret = @"0f3b6ae844a7ec9b9c02f20211e1cf6f";
/**
 *  OAuth时使用的RedirectURL
 */
NSString * const YJRedirectURL = @"http://";