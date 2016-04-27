//
//  ZCStatusToolbar.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/25.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusToolbar.h"
#import "ZCStatus.h"

@interface ZCStatusToolbar ()
/** 评论按钮*/
@property (nonatomic, weak) UIButton *commentButton;
/** 转发按钮*/
@property (nonatomic, weak) UIButton *repostButton;
/** 点赞*/
@property (nonatomic, weak) UIButton *attitudeButton;
@end
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
        
        self.repostButton =  [self setupButton:@"转发" iconName:@"timeline_icon_retweet"];
        self.commentButton = [self setupButton:@"评论" iconName:@"timeline_icon_comment"];
        self.attitudeButton =  [self setupButton:@"赞" iconName:@"timeline_icon_unlike"];

    }
    
    return self;
}

- (UIButton *)setupButton:(NSString *)title iconName:(NSString *)iconName
{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:btn];
    
    return btn;
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

- (void)setStatus:(ZCStatus *)status
{
    _status = status;
    

    [self setButtonCount:status.reposts_count button:self.repostButton title:@"转发"];
    [self setButtonCount:status.comments_count button:self.commentButton title:@"评论"];
    [self setButtonCount:status.attitudes_count button:self.attitudeButton title:@"赞"];

    
}

- (void)setButtonCount:(int)count button:(UIButton *)button title:(NSString *)title
{
    if (count) {
    
        
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

@end
