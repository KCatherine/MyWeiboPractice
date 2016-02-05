//
//  YJIconView.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJIconView.h"
#import "YJUserModel.h"

#import "UIImageView+WebCache.h"

@interface YJIconView ()
/**
 *  认证图片
 */
@property (nonatomic, weak) UIImageView *verifyView;

@end

@implementation YJIconView

- (UIImageView *)verifyView {
    if (!_verifyView) {
        UIImageView *verifyView = [[UIImageView alloc] init];
        [self addSubview:verifyView];
        self.verifyView = verifyView;
    }
    return _verifyView;
}

- (void)setOneUser:(YJUserModel *)oneUser {
    _oneUser = oneUser;
    
    [self sd_setImageWithURL:[NSURL URLWithString:oneUser.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (oneUser.verified_type) {
//        case YJUserVerifiedTypeNone:
//            self.verifyView.hidden = YES;
//            break;
//            
        case YJUserVerifiedTypePersonal:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case YJUserVerifiedTypeOrgEnterprice:
        case YJUserVerifiedTypeOrgWebsite:
        case YJUserVerifiedTypeOrgMedia:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case YJUserVerifiedTypeDaren:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifyView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.verifyView.size = self.verifyView.image.size;
    CGFloat scale = 0.6;
    self.verifyView.x = self.width - self.verifyView.width * scale;
    self.verifyView.y = self.height - self.verifyView.height * scale;
//    self.verifyView.centerX = self.width;
//    self.verifyView.centerY = self.height;
}

@end
