//
//  ZCAccount.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDate *create_time;
/** 用户昵称*/
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDictionary:(NSDictionary *)dictionary;


@end
