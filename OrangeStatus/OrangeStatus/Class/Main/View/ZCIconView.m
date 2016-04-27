//
//  ZCIconView.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/27.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCIconView.h"
#import "UIImageView+WebCache.h"
#import "ZCUser.h"

@interface ZCIconView ()
/** 认证头像*/
@property (nonatomic, weak) UIImageView *verifiedView;
@end
@implementation ZCIconView

- (UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    
    return _verifiedView;
}

- (void)setUser:(ZCUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    switch (user.verified_type) {
        case ZCUserVerifiedTypeNone:
            self.verifiedView.hidden = YES;
            break;
        case ZCUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case ZCUserVerifiedOrgEnterprice:
        case ZCUserVerifiedOrgMedia:
        case ZCUserVerifiedOrgWebsite:
            
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case ZCUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    double scale =0.6 ;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}
@end
