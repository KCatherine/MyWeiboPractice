//
//  YJHttpTool.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/5.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJHttpTool.h"

#import "AFNetworking.h"

@implementation YJHttpTool

+ (void)GET:(NSString *)URL
 parameters:(NSDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
    
    //创建网络管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //发送GET请求
    [mgr GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)POST:(NSString *)URL
  parameters:(NSDictionary *)parameters
     success:(void (^)(id _Nullable responseObject))success
     failure:(void (^)(NSError * _Nonnull error))failure {
    
    //创建网络管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //发送POST请求
    [mgr POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if (success) {
              success(responseObject);
          }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if (failure) {
              failure(error);
          }
    }];
}

@end
