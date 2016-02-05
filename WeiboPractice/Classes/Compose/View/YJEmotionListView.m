//
//  YJEmotionListView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/3.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionListView.h"
#import "YJEmotionPageView.h"

@interface YJEmotionListView ()<UIScrollViewDelegate>
/**
 *  显示表情的scrollView
 */
@property (nonatomic, weak) UIScrollView *emotionScroll;
/**
 *  显示页数的pageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation YJEmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIScrollView *emotionScroll = [[UIScrollView alloc] init];
        emotionScroll.delegate = self;
        emotionScroll.pagingEnabled = YES;
        emotionScroll.showsHorizontalScrollIndicator = NO;
        emotionScroll.showsVerticalScrollIndicator = NO;
        emotionScroll.bounces = NO;
        
        self.emotionScroll = emotionScroll;
        [self addSubview:emotionScroll];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;

        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    [self.emotionScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
#warning regular : (count + pagesize - 1) / pagesize
    NSUInteger pages = (emotions.count + EMOTION_PER_PAGE - 1) / EMOTION_PER_PAGE;
    
    self.pageControl.numberOfPages = pages;
    
    for (NSUInteger i = 0; i < pages; i++) {
        YJEmotionPageView *pageView = [[YJEmotionPageView alloc] init];
        
        NSRange range;
        range.location = i * EMOTION_PER_PAGE;
        
        NSUInteger left = emotions.count - range.location;
        
        if (left >= EMOTION_PER_PAGE) {
            range.length = EMOTION_PER_PAGE;
        } else {
            range.length = left;
        }
        
        pageView.onePageEmotions = [emotions subarrayWithRange:range];
        
        [self.emotionScroll addSubview:pageView];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 34;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.emotionScroll.width = self.width;
    self.emotionScroll.height = self.height - self.pageControl.height;
    self.emotionScroll.x = 0;
    self.emotionScroll.y = 0;
    
    NSUInteger pages = self.emotionScroll.subviews.count;
    for (NSUInteger i = 0; i < pages; i++) {
        YJEmotionPageView *pageView = self.emotionScroll.subviews[i];
        pageView.height = self.emotionScroll.height;
        pageView.width = self.emotionScroll.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    self.emotionScroll.contentSize = CGSizeMake(pages * self.emotionScroll.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
