//
//  ZCDropDownMenu.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/22.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCDropDownMenu.h"


@interface ZCDropDownMenu ()
@property (nonatomic, weak) UIImageView *containerView;
@end
@implementation ZCDropDownMenu

- (UIImageView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
        containerView.userInteractionEnabled = YES;
        containerView.width = 217;
        containerView.height = 400;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (void)showFromView:(UIView *)fromView
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);

    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }

}

- (void)dimiss
{
    [self removeFromSuperview];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    contentView.x = 10;
    contentView.y = 15;
    
    contentView.width = self.containerView.width - 2 * contentView.x;
    self.containerView.height = CGRectGetMaxY(contentView.frame) + 10;
    
    [self.containerView addSubview:contentView];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    
    self.contentView = contentViewController.view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dimiss];
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

@end
