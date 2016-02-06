//
//  YJNewFeatureController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/29.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#define TotalImage 4

#import "YJNewFeatureController.h"
#import "YJMainTabController.h"

@interface YJNewFeatureController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *imageScroll;
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation YJNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *imageScroll = [[UIScrollView alloc] init];
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    imageScroll.frame = self.view.bounds;
    pageControl.centerX = self.view.centerX;
    pageControl.y = imageScroll.height * 0.95;
    
    CGFloat imageW = imageScroll.width;
    CGFloat imageH = imageScroll.height;
    for (NSInteger i = 0; i < TotalImage; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld", i + 1]];
        imageView.frame = CGRectMake(i * imageW, 0, imageW, imageH);
        [imageScroll insertSubview:imageView atIndex:0];
        
        if (i == TotalImage - 1) {
            [self setUpLastImageView:imageView];
        }
    }
    imageScroll.delegate = self;
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.pagingEnabled = YES;
    imageScroll.bounces = NO;
    imageScroll.contentSize = CGSizeMake(TotalImage * imageW, 0);
    
    pageControl.numberOfPages = TotalImage;
    pageControl.currentPageIndicatorTintColor = YJ_COLOR(253, 98, 42);
    pageControl.pageIndicatorTintColor = YJ_COLOR(189, 189, 189);
    
    self.imageScroll = imageScroll;
    self.pageControl = pageControl;
    
    [self.view addSubview:imageScroll];
    [self.view addSubview:pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpLastImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    
    UIButton *share = [[UIButton alloc] init];
    [share addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:15];
    share.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    share.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    share.width = 120;
    share.height = 30;
    share.centerX = imageView.width * 0.5;
    share.centerY = imageView.height * 0.65;
    
    UIButton *enter = [[UIButton alloc] init];
    [enter addTarget:self action:@selector(enterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [enter setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enter setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enter setTitle:@"进入微博" forState:UIControlStateNormal];
    enter.size = enter.currentBackgroundImage.size;
    enter.centerX = share.centerX;
    enter.centerY = imageView.height * 0.75;
    
    [imageView addSubview:share];
    [imageView addSubview:enter];
}

- (void)shareButtonClick:(UIButton *)btn {
    btn.selected = !btn.isSelected;
}

- (void)enterButtonClick {
    YJMainTabController *mainTabController = [[YJMainTabController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabController;
}

#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = (scrollView.contentOffset.x + scrollView.width * 0.5) / scrollView.width;
    self.pageControl.currentPage = page;
}

@end
