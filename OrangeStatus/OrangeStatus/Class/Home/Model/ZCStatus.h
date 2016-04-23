//
//  ZCStatus.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCUser;

@interface ZCStatus : NSObject


/** idstr	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/** text	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/** user	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong)  ZCUser *user;


@end
