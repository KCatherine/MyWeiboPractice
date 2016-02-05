//
//  YJAccountTool.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJAccountModel.h"

@interface YJAccountTool : NSObject
/**
 *  存储接受到的账号数据
 *
 *  @param account 接收到的账号模型
 */
+ (void)saveAccount:(YJAccountModel *)account;
/**
 *  加载本地的账号模型
 *
 *  @return 账号模型
 */
+ (YJAccountModel *)loadAccount;

@end
