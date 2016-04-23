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
#import "UIImage+Extension.h"
#import "ZCTabBar.h"

@interface ZCTabBarController () <ZCTabBarDelegate>

@end

@implementation ZCTabBarController

+ (void)initialize
{
    //获取所有的UITabBarItem的外观属性
//    UITabBarItem *item = [UITabBarItem appearance];
    //获取当前类的所有UITabBarItem的外观属性
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttribute = [NSMutableDictionary dictionary];
    selectedTextAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:selectedTextAttribute forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAllChildViewController];
    


}

- (void)setAllChildViewController
{
    
    ZCHomeController *home = [[ZCHomeController alloc] init];
    UIImage *homeImage = [UIImage imageNamed:@"tabbar_home"];
    UIImage *homeSelectedImage = [UIImage imageWithOriginaName:@"tabbar_home_selected"];
    [self addOneChildViewController:home title:@"首页" image:homeImage selectedImage:homeSelectedImage];
    
    ZCMessageController *message = [[ZCMessageController alloc] init];
    UIImage *messageImage = [UIImage imageNamed:@"tabbar_message_center"];
    UIImage *selectedMessageImage = [UIImage imageWithOriginaName:@"tabbar_message_center_selected"];
    [self addOneChildViewController:message title:@"消息" image:messageImage selectedImage:selectedMessageImage];
    
    
    ZCDiscoverController *discover = [[ZCDiscoverController alloc] init];
    UIImage *discoverImage = [UIImage imageNamed:@"tabbar_discover"];
    UIImage *selectedDiscoverImage = [UIImage imageWithOriginaName:@"tabbar_discover_selected"];
    [self addOneChildViewController:discover title:@"发现" image:discoverImage selectedImage:selectedDiscoverImage];
    
    ZCProfileController *profile = [[ZCProfileController alloc] init];
    UIImage *profileImage = [UIImage imageNamed:@"tabbar_profile"];
    UIImage *selectedProfielImage = [UIImage imageWithOriginaName:@"tabbar_profile_selected"];
    [self addOneChildViewController:profile title:@"我" image:profileImage selectedImage:selectedProfielImage];
    
    
    ZCTabBar *tabBar = [[ZCTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)addOneChildViewController:(UIViewController *)childViewController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    childViewController.title = title;
    childViewController.tabBarItem.image = image;
    childViewController.tabBarItem.selectedImage = selectedImage;
    

    
    ZCNavigaionController *naviVC = [[ZCNavigaionController alloc] initWithRootViewController:childViewController];
    
    [self addChildViewController:naviVC];



}

#pragma  mark - ZCTabBarDelegate
- (void)tabBarDidClickPlusButton:(ZCTabBar *)tabBar
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
