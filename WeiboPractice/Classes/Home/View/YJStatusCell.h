//
//  YJStatusCell.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/31.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJStatusFrame;

@interface YJStatusCell : UITableViewCell
/**
 *  传入的cell的frame模型
 */
@property (nonatomic, strong) YJStatusFrame *statusCellFrame;

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
