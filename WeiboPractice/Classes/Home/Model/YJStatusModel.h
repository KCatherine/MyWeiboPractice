//
//  YJStatusModel.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJUserModel;

@interface YJStatusModel : NSObject

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博作者的用户信息字段
 */
@property (nonatomic, strong) YJUserModel *user;
/**
 *  微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 */
@property (nonatomic, strong) NSMutableArray *pic_urls;
/**
 *  被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic, strong) YJStatusModel *retweeted_status;
/**
 *  转发数
 */
@property (nonatomic, assign) NSInteger reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) NSInteger comments_count;
/**
 *  赞数
 */
@property (nonatomic, assign) NSInteger attitudes_count;

@end
