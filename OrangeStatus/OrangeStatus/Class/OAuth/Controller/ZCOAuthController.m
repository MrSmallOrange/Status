//
//  ZCOAuthController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//App Key：3288281858
//App Secret：90aecde1a84a96801b16aa20ed637156
//https://api.weibo.com/oauth2/authorize


#import "ZCOAuthController.h"
#import "AFNetworking.h"
#import "ZCTabBarController.h"
#import "ZCNewfeatureController.h"
#import "ZCAccount.h"
#import "MBProgressHUD+MJ.h"

@interface ZCOAuthController () <UIWebViewDelegate>

@end

@implementation ZCOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //client_id	true	string	申请应用时分配的AppKey。
    //redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    NSURL *URL = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3288281858&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载数据..."];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}


//拦截webView的所有请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获得URL
    NSString *URL = request.URL.absoluteString;
    
    NSRange range = [URL rangeOfString:@"code="];
    if (range.length > 0) {
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [URL substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        return NO;
    }
    
    //所有请求都能通过
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    
    /* 
     https://api.weibo.com/oauth2/access_token
     
     
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     
     App Key：3288281858
     App Secret：90aecde1a84a96801b16aa20ed637156
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
  
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"3288281858";
    parameters[@"client_secret"] = @"90aecde1a84a96801b16aa20ed637156";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.baidu.com";

    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUD];
        
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *accountPath = [documentPath stringByAppendingPathComponent:@"account.plist"];
        [responseObject writeToFile:accountPath atomically:YES];
        
        [NSKeyedArchiver archiveRootObject:responseObject toFile:accountPath];
        
        
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

       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败----%@", error);
        [MBProgressHUD hideHUD];
    }];
    
    
    
    
}


@end
