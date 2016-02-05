//
//  YJStatusPhotosView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJStatusPhotosView.h"
#import "YJStatusPhoto.h"
#import "YJStatusPhotoView.h"

#define STATUS_PHOTO_WH 70
#define PHOTO_MARGIN 10
#define MAX_COLUMNS(COUNT) ((COUNT==4)?2:3)

@implementation YJStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setPhotosArray:(NSArray *)photosArray {
    _photosArray = photosArray;
    
    NSInteger photosCount = photosArray.count;
    
    //创建缺少的ImageView
    while (self.subviews.count < photosCount) {
        YJStatusPhotoView *photoView = [[YJStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    //遍历所有ImageView，找出显示和隐藏的状态
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        YJStatusPhotoView *imgView = self.subviews[i];
        if (i < photosCount) {
            imgView.onePhoto = photosArray[i];
            imgView.hidden = NO;
        } else {
            imgView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger photosCount = self.photosArray.count;
    for (NSInteger i = 0; i < photosCount; i++) {
        YJStatusPhotoView *imgView = self.subviews[i];
        
        NSInteger col = i % MAX_COLUMNS(photosCount);
        NSInteger row = i / MAX_COLUMNS(photosCount);
        
        imgView.width = STATUS_PHOTO_WH;
        imgView.height = STATUS_PHOTO_WH;
        imgView.x = col * (STATUS_PHOTO_WH + PHOTO_MARGIN);
        imgView.y = row * (STATUS_PHOTO_WH + PHOTO_MARGIN);
    }
}

+ (CGSize)sizeWithCount:(NSInteger)count {
    
    NSInteger col = count > MAX_COLUMNS(count) - 1 ? MAX_COLUMNS(count) : count;
    CGFloat photosW = col * STATUS_PHOTO_WH + (col - 1) * PHOTO_MARGIN;
    
    NSInteger row = count / MAX_COLUMNS(count);
    if (count % MAX_COLUMNS(count) != 0) {
        row += 1;
    }
    CGFloat photosH = row * STATUS_PHOTO_WH + (row - 1) * PHOTO_MARGIN;
    
    return CGSizeMake(photosW, photosH);
}

@end
