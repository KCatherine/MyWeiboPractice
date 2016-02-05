//
//  YJAccountModel.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJAccountModel.h"

#import "MJExtension.h"

@implementation YJAccountModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
//        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
//        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
//        self.uid = [aDecoder decodeObjectForKey:@"uid"];
//        
//        self.create_date = [aDecoder decodeObjectForKey:@"create_date"];
//        self.username = [aDecoder decodeObjectForKey:@"username"];
        [self mj_decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.access_token forKey:@"access_token"];
//    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
//    [aCoder encodeObject:self.uid forKey:@"uid"];
//    
//    [aCoder encodeObject:self.create_date forKey:@"create_date"];
//    [aCoder encodeObject:self.username forKey:@"username"];
    [self mj_encode:aCoder];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
        //接收到账号信息时存储当前日期时间
        self.create_date = [NSDate date];
    }
    return self;
}

+ (instancetype)accountModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
