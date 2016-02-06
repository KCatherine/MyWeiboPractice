//
//  YJStatusCell.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/31.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusCell.h"
#import "YJStatusFrame.h"
#import "YJStatusModel.h"
#import "YJUserModel.h"
#import "YJStatusPhoto.h"
#import "YJStatusToolBar.h"
#import "YJStatusPhotosView.h"
#import "YJIconView.h"
#import "YJStatusTextView.h"

#import "UIImageView+WebCache.h"

@interface YJStatusCell ()
//原创微博
@property (nonatomic, weak) UIButton *original;
@property (nonatomic, weak) YJIconView *iconView;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) YJStatusPhotosView *photosView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) YJStatusTextView *contentLabel;
//转发微博
@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) YJStatusTextView *retweetContentLabel;
@property (nonatomic, weak) YJStatusPhotosView *retweetPhotosView;
//工具条
@property (nonatomic, weak) YJStatusToolBar *toolBar;


@end

@implementation YJStatusCell

- (void)setFrame:(CGRect)frame {
    frame.origin.y += CELL_BORDER_WIDTH;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

//        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
//        bg.image = [UIImage imageNamed:@"timeline_card_top_background"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setUpOriginal];
        [self setUpReTweet];
        [self setUpToolBar];
    }
    return self;
}
//进行原创微博模块控件的添加和设置
- (void)setUpOriginal {
    //原创微博模块
    UIButton *original = [[UIButton alloc] init];
    [original setBackgroundImage:[UIImage imageNamed:@"timeline_card_top_background"] forState:UIControlStateNormal];
    [original setBackgroundImage:[UIImage imageNamed:@"timeline_card_top_background_highlighted"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:original];
    self.original = original;
    
    // 1.头像
    YJIconView *iconView = [[YJIconView alloc] init];
    [original addSubview:iconView];
    self.iconView = iconView;
    
    // 2.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = NameFont;
    [original addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 3.会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    [original addSubview:vipView];
    self.vipView = vipView;
    
    // 4.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = TimeFont;
    sourceLabel.textColor = YJ_COLOR(166, 166, 166);
    [original addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 5.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = TimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [original addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //6.内容
    YJStatusTextView *contentLabel = [[YJStatusTextView alloc] init];
    contentLabel.font = TextFont;
    [original addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 7.配图
    YJStatusPhotosView *photoView = [[YJStatusPhotosView alloc] init];
    [original addSubview:photoView];
    self.photosView = photoView;
}
//进行转发微博模块控件的添加和设置
- (void)setUpReTweet {
    //转发微博模块
    UIImage *reTweetBackgroundImage = [UIImage imageNamed:@"timeline_retweet_background"];
    UIImage *reTweetBackgroundImageHightLighted = [UIImage imageNamed:@"timeline_retweet_background_highlighted"];
//    UIColor *reTweetBackgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    UIButton *retweet = [UIButton buttonWithType:UIButtonTypeCustom];
    [retweet setBackgroundImage:reTweetBackgroundImage forState:UIControlStateNormal];
    [retweet setBackgroundImage:reTweetBackgroundImageHightLighted forState:UIControlStateHighlighted];
    [self.contentView addSubview:retweet];
    self.retweet = retweet;
    
    //1.内容
    YJStatusTextView *retweetContentLabel = [[YJStatusTextView alloc] init];
    retweetContentLabel.font = ReTweetTextFont;
    [retweet addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 2.配图
    YJStatusPhotosView *retweetPhotoView = [[YJStatusPhotosView alloc] init];
    [retweet addSubview:retweetPhotoView];
    self.retweetPhotosView = retweetPhotoView;
}
//进行工具条控件的添加和设置
- (void)setUpToolBar {
    YJStatusToolBar *toolBar = [YJStatusToolBar statusToolBar];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}
//重写模型的setter进行控件的frame设置
- (void)setStatusCellFrame:(YJStatusFrame *)statusCellFrame {
    _statusCellFrame = statusCellFrame;
    
    YJStatusModel *oneStatus = statusCellFrame.statusModel;
    YJUserModel *oneUser = oneStatus.user;
    
    self.original.frame = statusCellFrame.originalF;
    
    self.iconView.frame = statusCellFrame.iconViewF;
    self.iconView.oneUser = oneUser;
    
    if (oneUser.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusCellFrame.vipViewF;
        NSString *vipImgName = [NSString stringWithFormat:@"common_icon_membership_level%ld", oneUser.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImgName];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    if (oneStatus.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = statusCellFrame.photosViewF;

        self.photosView.photosArray = oneStatus.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    self.nameLabel.frame = statusCellFrame.nameLabelF;
    self.nameLabel.text = oneUser.name;
    
    NSString *time = oneStatus.created_at;
    CGFloat timeX = statusCellFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusCellFrame.nameLabelF) + CELL_BORDER_WIDTH;
    CGSize timeSize = [time sizeWithFont:TimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.text = time;
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + CELL_BORDER_WIDTH;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [oneStatus.source sizeWithFont:TimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    self.sourceLabel.text = oneStatus.source;
    
    self.contentLabel.frame = statusCellFrame.contentLabelF;
    self.contentLabel.attributedText = oneStatus.attributedText;
    
    //如果有转发微博则设置
    if (oneStatus.retweeted_status) {
        YJStatusModel *oneReTweetStatus = oneStatus.retweeted_status;
        
        self.retweet.hidden = NO;
        self.retweet.frame = statusCellFrame.retweetF;
        
        self.retweetContentLabel.frame = statusCellFrame.retweetContentLabelF;
        self.retweetContentLabel.attributedText = oneStatus.retweetedAttributedText;

        if (oneStatus.retweeted_status.pic_urls.count) {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = statusCellFrame.retweetPhotosViewF;

            self.retweetPhotosView.photosArray = oneReTweetStatus.pic_urls;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweet.hidden = YES;
    }
    
    //设置工具条
    self.toolBar.frame = statusCellFrame.toolBarF;
    self.toolBar.oneStatus = oneStatus;
}

+ (instancetype)statusCellWithTableView:(UITableView *)tableView {
    static NSString *reuseID = @"WeiboCell";
    YJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[YJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    return cell;
}

@end
