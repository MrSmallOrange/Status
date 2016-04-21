//
//  ZCTabBarController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//
// RGB颜色
#define ZCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "ZCTabBarController.h"
#import "ZCHomeController.h"
#import "ZCMessageController.h"
#import "ZCDiscoverController.h"
#import "ZCProfileController.h"
#import "ZCNavigaionController.h"

@interface ZCTabBarController ()

@end

@implementation ZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZCHomeController *home = [[ZCHomeController alloc] init];
    UIImage *homeImage = [UIImage imageNamed:@"tabbar_home"];
    UIImage *homeSelectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addOneChildViewController:home title:@"首页" image:homeImage selectedImage:homeSelectedImage];
    
    ZCMessageController *message = [[ZCMessageController alloc] init];
    UIImage *messageImage = [UIImage imageNamed:@"tabbar_message_center"];
    UIImage *selectedMessageImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addOneChildViewController:message title:@"消息" image:messageImage selectedImage:selectedMessageImage];
    
    ZCDiscoverController *discover = [[ZCDiscoverController alloc] init];
    UIImage *discoverImage = [UIImage imageNamed:@"tabbar_discover"];
    UIImage *selectedDiscoverImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addOneChildViewController:discover title:@"发现" image:discoverImage selectedImage:selectedDiscoverImage];
    
    ZCProfileController *profile = [[ZCProfileController alloc] init];
    UIImage *profileImage = [UIImage imageNamed:@"tabbar_profile"];
    UIImage *selectedProfielImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addOneChildViewController:profile title:@"我" image:profileImage selectedImage:selectedProfielImage];
    
    
    
}

- (void)addOneChildViewController:(UIViewController *)childViewController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    childViewController.title = title;
    childViewController.tabBarItem.image = image;
    childViewController.tabBarItem.selectedImage = selectedImage;
    
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = ZCColor(123, 123, 123);
    [childViewController.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttribute = [NSMutableDictionary dictionary];
    selectedTextAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childViewController.tabBarItem setTitleTextAttributes:selectedTextAttribute forState:UIControlStateSelected];
    
    ZCNavigaionController *naviVC = [[ZCNavigaionController alloc] initWithRootViewController:childViewController];
    
    [self addChildViewController:naviVC];



}


@end
