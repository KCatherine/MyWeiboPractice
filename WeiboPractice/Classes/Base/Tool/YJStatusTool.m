//
//  YJStatusTool.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/13.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusTool.h"
#import "FMDB.h"

@implementation YJStatusTool

static FMDatabase *_db;

+ (void)initialize {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Statuses.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    //创建数据库中的表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_statuses (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}

+ (NSArray *)statusesWithParams:(NSDictionary *)params {
    //根据参数生成对应的SQL语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_statuses WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", params[@"since_id"]];
    } else if (params[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_statuses WHERE idstr < %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"]];
    } else {
        sql = @"SELECT * FROM t_statuses ORDER BY idstr DESC LIMIT 20;";
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        //获得字段内的NSData
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

+ (void)saveStatuses:(NSArray *)statuses {
    for (NSDictionary *status in statuses) {
        //将对象转为NSData存入到数据库的blob类型字段内
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_statuses(status, idstr) VALUES (%@, %@);", statusData, status[@"idstr"]];
    }
}

@end
