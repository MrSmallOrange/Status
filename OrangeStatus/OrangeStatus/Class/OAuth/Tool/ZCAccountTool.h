//
//  ZCAccountTool.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCAccount;
@interface ZCAccountTool : NSObject
+ (void)saveAccount:(ZCAccount *)account;
+ (ZCAccount *)account;
@end
