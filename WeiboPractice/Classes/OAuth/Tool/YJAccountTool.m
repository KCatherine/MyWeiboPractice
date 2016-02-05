//
//  YJAccountTool.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJAccountTool.h"

#define ACCOUNT_LOC [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation YJAccountTool

+ (void)saveAccount:(YJAccountModel *)account {
    
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_LOC];
}

+ (YJAccountModel *)loadAccount {
    
    YJAccountModel *accountModel = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_LOC];
    long long expires_in = [accountModel.expires_in longLongValue];
    NSDate *expiresDate = [accountModel.create_date dateByAddingTimeInterval:expires_in];
    NSDate *nowDate = [NSDate date];
    if ([expiresDate compare:nowDate]) {
        return accountModel;
    }
    return nil;
}

@end
