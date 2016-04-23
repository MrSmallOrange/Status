//
//  ZCNavigaionController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCNavigaionController.h"
#import "UIBarButtonItem+Extension.h"

@interface ZCNavigaionController ()

@end

@implementation ZCNavigaionController


- (void)viewDidLoad {
    [super viewDidLoad];
    


    
}





+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highlightedImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highlightedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:YES];
}

#pragma  mark - BarButtonItem Target
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{

}
@end
