//
//  YJStatusFrameCell.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/31.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusFrame.h"
#import "YJStatusModel.h"
#import "YJUserModel.h"
#import "YJStatusPhotosView.h"

@implementation YJStatusFrame

- (void)setStatusModel:(YJStatusModel *)statusModel {
    _statusModel = statusModel;
    
    //取出此条微博中的用户数据
    YJUserModel *user = statusModel.user;
    //获得cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //计算头像的frame
    CGFloat iconWH = 40;
    CGFloat iconX = CELL_BORDER_WIDTH;
    CGFloat iconY = CELL_BORDER_WIDTH;
    _iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    //计算昵称的frame
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + CELL_BORDER_WIDTH;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:NameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //如果是VIP，则计算VIP的frame
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) + CELL_BORDER_WIDTH;
        CGFloat vipY = nameY + 3;
        CGFloat vipW = 14;
        CGFloat vipH = 14;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //计算发送时间的frame
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + CELL_BORDER_WIDTH;
    CGSize timeSize = [statusModel.created_at sizeWithFont:TimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    //计算来源的frame
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + CELL_BORDER_WIDTH;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [statusModel.source sizeWithFont:TimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    //计算微博内容的frame
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + CELL_BORDER_WIDTH;
    CGFloat contentW = cellW - CELL_BORDER_WIDTH * 2;
    CGSize contentSize = [statusModel.attributedText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _contentLabelF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    //计算原创微博整体的frame
    CGFloat originalH = 0;
    if (statusModel.pic_urls.count) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(_contentLabelF) + CELL_BORDER_WIDTH;
        CGSize photosSize = [YJStatusPhotosView sizeWithCount:statusModel.pic_urls.count];
        _photosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        
        originalH = CGRectGetMaxY(_photosViewF) + CELL_BORDER_WIDTH;
    } else {
        originalH = CGRectGetMaxY(_contentLabelF) + CELL_BORDER_WIDTH;
    }
    
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    _originalF = CGRectMake(originalX, originalY, originalW, originalH);
    //计算转发微博的frame
    CGFloat toolBarY = 0;
    if (statusModel.retweeted_status) {
        YJStatusModel *oneReTweetStatus = statusModel.retweeted_status;
        
        CGFloat reTweetContentX = CELL_BORDER_WIDTH;
        CGFloat reTweetContentY = CELL_BORDER_WIDTH;
        CGSize reTweetContentSize = [statusModel.retweetedAttributedText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _retweetContentLabelF = CGRectMake(reTweetContentX, reTweetContentY, reTweetContentSize.width, reTweetContentSize.height);
        
        CGFloat reTweetH = 0;
        if (oneReTweetStatus.pic_urls.count) {
            CGFloat reTweetPhotosX = reTweetContentX;
            CGFloat reTweetPhotosY = CGRectGetMaxY(_retweetContentLabelF) + CELL_BORDER_WIDTH;
            CGSize reTweetPhotosSize = [YJStatusPhotosView sizeWithCount:oneReTweetStatus.pic_urls.count];
            _retweetPhotosViewF = CGRectMake(reTweetPhotosX, reTweetPhotosY, reTweetPhotosSize.width, reTweetPhotosSize.height);
            
            reTweetH = CGRectGetMaxY(_retweetPhotosViewF) + CELL_BORDER_WIDTH;
        } else {
            reTweetH = CGRectGetMaxY(_retweetContentLabelF) + CELL_BORDER_WIDTH;
        }
        
        CGFloat reTweetX = 0;
        CGFloat reTweetY = CGRectGetMaxY(_originalF);
        CGFloat reTweetW = cellW;
        _retweetF = CGRectMake(reTweetX, reTweetY, reTweetW, reTweetH);
        
        toolBarY = CGRectGetMaxY(_retweetF);

    } else {
        toolBarY = CGRectGetMaxY(_originalF);
    }
    //计算微博工具栏的frame
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 36;
    _toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    //计算整个cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarF) + CELL_BORDER_WIDTH;
}

@end
