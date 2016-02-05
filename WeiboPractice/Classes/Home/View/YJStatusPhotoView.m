//
//  YJStatusPhotoView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusPhotoView.h"
#import "YJStatusPhoto.h"

#import "UIImageView+WebCache.h"

@interface YJStatusPhotoView ()
/**
 *  需要显示的GIF标识
 */
@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation YJStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)gifView {
    if (!_gifView) {
        UIImage *gif = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:gif];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (void)setOnePhoto:(YJStatusPhoto *)onePhoto {
    _onePhoto = onePhoto;
    
    [self sd_setImageWithURL:[NSURL URLWithString:onePhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![onePhoto.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
