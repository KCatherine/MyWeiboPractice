//
//  YJEmotionMagnifier.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/4.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJEmotionMagnifier.h"
#import "YJEmotionButton.h"
#import "YJEmotion.h"

@interface YJEmotionMagnifier ()

@property (weak, nonatomic) IBOutlet YJEmotionButton *showedEmotionBtn;


@end

@implementation YJEmotionMagnifier

+ (instancetype)emotionMagnifier {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJEmotionMagnifier" owner:nil options:nil] lastObject];
}

- (void)showFrom:(YJEmotionButton *)button {
    if (button == nil) return;
        
    //获得当前最上面的window
    UIWindow *now = [UIApplication sharedApplication].windows.lastObject;
    [now addSubview:self];
    //计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
    
    self.showedEmotionBtn.oneEmotion = button.oneEmotion;
}

@end
