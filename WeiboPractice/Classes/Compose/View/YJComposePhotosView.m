//
//  YJComposePhotosView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJComposePhotosView.h"

@implementation YJComposePhotosView

- (void)addPhoto:(UIImage *)image {
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = image;
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.clipsToBounds = YES;
    [self addSubview:photoView];
    
    [self.photos addObject:image];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger photosCount = self.subviews.count;
    NSInteger maxCol = 3;
    CGFloat imageWH = 93;
    CGFloat imageM = 10;
    
    for (NSInteger i = 0; i < photosCount; i++) {
        UIImageView *imgView = self.subviews[i];
        
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        
        imgView.width = imageWH;
        imgView.height = imageWH;
        imgView.x = imageM + col * (imageWH + imageM);
        imgView.y = imageM + row * (imageWH + imageM);
    }
}

@end
