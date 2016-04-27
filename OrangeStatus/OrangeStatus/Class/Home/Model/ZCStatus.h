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
/** 创建时间*/
@property (nonatomic, copy) NSString *created_at;
/** 微博来源*/
@property (nonatomic, copy) NSString *source;
/** 数组里面的元素是图片的路径*/
@property (nonatomic, strong) NSArray *pic_urls;
/** 转发微博*/
@property (nonatomic, strong) ZCStatus *retweeted_status;
/** 转发数*/
@property (nonatomic, assign) int reposts_count;
/** 评论数*/
@property (nonatomic, assign) int comments_count;
/** 点赞数*/
@property (nonatomic, assign) int attitudes_count;




@end
