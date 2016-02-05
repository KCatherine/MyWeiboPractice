//
//  YJStatusFrameCell.h
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/31.
//  Copyright © 2016年 杨璟. All rights reserved.
//CellBorderW

#import <Foundation/Foundation.h>

#define CELL_BORDER_WIDTH 10
#define NameFont [UIFont systemFontOfSize:14]
#define TimeFont [UIFont systemFontOfSize:12]
#define TextFont [UIFont systemFontOfSize:15]
#define ReTweetTextFont [UIFont systemFontOfSize:13]

@class YJStatusModel;

@interface YJStatusFrame : NSObject
/**
 *  frame模型所包含的status模型
 */
@property (nonatomic, strong) YJStatusModel *statusModel;

/**
 *  原创微博整体的frame
 */
@property (nonatomic, assign, readonly) CGRect originalF;
/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/**
 *  VIP图片的frame
 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/**
 *  微博配图的frame
 */
@property (nonatomic, assign, readonly) CGRect photosViewF;
/**
 *  用户名称的frame
 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/**
 *  发送时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/**
 *  微博来源的frame
 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/**
 *  微博内容的frame
 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;


/**
 *  转发微博整体的frame
 */
@property (nonatomic, assign, readonly) CGRect retweetF;
/**
 *  微博配图的frame
 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;
/**
 *  转发微博内容的frame
 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;

/**
 *  工具条的frame
 */
@property (nonatomic, assign, readonly) CGRect toolBarF;

/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
