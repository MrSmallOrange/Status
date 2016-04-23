//
//  UIWindow+Extension.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "ZCTabBarController.h"
#import "ZCNewfeatureController.h"

@implementation UIWindow (Extension)
+ (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([lastVersion isEqualToString:currentVersion]) {
        window.rootViewController = [[ZCTabBarController alloc] init];
    }else{
        window.rootViewController = [[ZCNewfeatureController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
