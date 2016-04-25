//
//  ZCStatusToolbar.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/25.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusToolbar.h"

@implementation ZCStatusToolbar

+ (instancetype)toolbar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        [self setupButton:@"转发" iconName:@"timeline_icon_retweet"];
        [self setupButton:@"评论" iconName:@"timeline_icon_comment"];
        [self setupButton:@"赞" iconName:@"timeline_icon_unlike"];

    }
    
    return self;
}

- (void)setupButton:(NSString *)title iconName:(NSString *)iconName
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;

    }
}

@end
