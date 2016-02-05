//
//  YJUserModel.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YJUserVerifiedType) {
    YJUserVerifiedTypeNone          = -1,   //没有认证
    YJUserVerifiedTypePersonal      = 0,    //个人认证
    YJUserVerifiedTypeOrgEnterprice = 2,    //企业认证
    YJUserVerifiedTypeOrgMedia      = 3,    //媒体认证
    YJUserVerifiedTypeOrgWebsite    = 5,    //网站认证
    YJUserVerifiedTypeDaren         = 220   //打人认证
};

@interface YJUserModel : NSObject

/**
 *  字符串型的用户UID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户头像地址（中图），50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (nonatomic, assign) NSInteger mbrank;
/**
 *  会员类型，> 2 代表是会员
 */
@property (nonatomic, assign) NSInteger mbtype;
/**
 *  用户认证类型
 */
@property (nonatomic, assign) YJUserVerifiedType verified_type;

/**
 *  是否是VIP
 */
@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
