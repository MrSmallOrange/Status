//
//  AppDelegate.m
//  OrangeStatus

//App Key：3288281858
//App Secret：90aecde1a84a96801b16aa20ed637156
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import "ZCOAuthController.h"
#import "ZCAccount.h"
#import "ZCAccountTool.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    
    ZCAccount *account = [ZCAccountTool account];

    
    if ( account) {

        [UIWindow switchRootViewController];
        
    }else{
        self.window.rootViewController = [[ZCOAuthController alloc] init];
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //请求管理者
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //取消下载
    [manager cancelAll];
    //清除内存中所有的图片
    [manager.imageCache clearMemory];
}

@end
