//
//  ZCNewfeatureController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/22.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCNewfeatureController.h"
#import "ZCTabBarController.h"
#define ZCNewfeatureCount 4

@interface ZCNewfeatureController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ZCNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame =  self.view.bounds;
//    scrollView.delegate = self;
    CGFloat scrollViewWidth = scrollView.width;
    CGFloat scrollViewHeight = scrollView.height;
    
    scrollView.contentSize = CGSizeMake(ZCNewfeatureCount * scrollViewWidth, scrollViewHeight);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    for (int i = 0; i < ZCNewfeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1 ];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        imageView.size = scrollView.size;
        imageView.y = 0;
        imageView.x = scrollViewWidth * i;
        
        if (i == ZCNewfeatureCount - 1) {
            [self setUpLastImageView:imageView];
        }
    }
    [self.view addSubview:scrollView];

    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZCNewfeatureCount;
    pageControl.width =100;
    pageControl.height = 30;
//    pageControl.x = scrollView.centerX - pageControl.width * 0.5 ;
    pageControl.centerX = self.view.centerX;
    pageControl.y = 600;
    pageControl.currentPageIndicatorTintColor = ZCColor(253, 98, 42);
    pageControl.pageIndicatorTintColor   = ZCColor(189, 189, 189);
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)setUpLastImageView:(UIImageView *)imageView
{
    UIButton *shareButton = [[UIButton alloc] init];
    shareButton.width = 100;
    shareButton.height = 30;
    shareButton.centerX = self.view.centerX;
    shareButton.y = 400;
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [imageView addSubview:shareButton];
    
    
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton sizeToFit];
    startButton.centerX = self.view.centerX;
    startButton.y = 470;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
}
- (void)clickShareButton:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.selected;
}

- (void)clickStartButton
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[ZCTabBarController alloc] init];
}

@end
