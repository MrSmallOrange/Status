//
//  ZCAccountTool.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCAccountTool.h"
#import "ZCAccount.h"
#define ZCAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.plist"]

@implementation ZCAccountTool
+ (void)saveAccount:(ZCAccount *)account
{
    

    [NSKeyedArchiver archiveRootObject:account toFile:ZCAccountPath];

    
    
}

+ (ZCAccount *)account
{
    ZCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZCAccountPath];
    
    //账号有效时间
    long long expiers_in = [account.expires_in longLongValue];
    
    //账号过期时刻：账号创建时间+账号有效时间
    NSDate *expiersTime = [account.create_time dateByAddingTimeInterval:expiers_in];
    
    //当前时间
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiersTime compare:now];
    
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    
    return account;
}
@end
