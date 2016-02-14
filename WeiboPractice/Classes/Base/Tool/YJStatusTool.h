//
//  YJStatusTool.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/13.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJStatusTool : NSObject
/**
 *  根据请求参数从沙盒数据库中获取数据
 *
 *  @param params 参数集合
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;
/**
 *  存储微博数据到数据库中
 *
 *  @param statuses 需要存储的微博数据
 */
+ (void)saveStatuses:(NSArray *)statuses;

@end
