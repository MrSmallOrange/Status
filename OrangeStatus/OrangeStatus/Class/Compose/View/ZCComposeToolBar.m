//
//  ZCComposeToolBar.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/28.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCComposeToolBar.h"

@implementation ZCComposeToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
      
        [self setupButtonWithImage:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:ZCComposeToolBarTypeCamere];
        [self setupButtonWithImage:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:ZCComposeToolBarTypePicture];
        [self setupButtonWithImage:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:ZCComposeToolBarTypeMention];
        [self setupButtonWithImage:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:ZCComposeToolBarTypeTrend];
        [self setupButtonWithImage:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:ZCComposeToolBarTypeEmotion];

      
    }
    return self;
}


- (void)setupButtonWithImage:(NSString *)imageName hightImage:(NSString *)hightImageName type:(ZCComposeToolBarType)type
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImageName] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = type;
    [self addSubview:button];
}

- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didButtonType:)]) {
        [self.delegate composeToolBar:self didButtonType:(ZCComposeToolBarType)button.tag];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width / self.subviews.count;
    CGFloat height = self.height;
    
    NSUInteger count = self.subviews.count;
    
    for (NSUInteger i = 0; i < count; i ++) {
        UIButton *button = self.subviews[i];
        button.width  = width;
        button.height = height;
        button.y = 0 ;
        button.x = i * width;
    }
}

@end
