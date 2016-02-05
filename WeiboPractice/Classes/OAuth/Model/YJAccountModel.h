//
//  YJAccountModel.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJAccountModel : NSObject<NSCoding>
//        access_token 用于调用access_token，接口获取授权后的access token。
//        expires_in access_token的生命周期，单位是秒数。
//        remind_in access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
//        uid 当前授权用户的UID。

/**
 *  用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSNumber *expires_in;
/**
 *  当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  当前授权用户的用户名
 */
@property (nonatomic, copy) NSString *username;
/**
 *  创建账号的日期时间
 */
@property (nonatomic, strong) NSDate *create_date;

+ (instancetype)accountModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
