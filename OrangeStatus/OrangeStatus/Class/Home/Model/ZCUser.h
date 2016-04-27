//
//  ZCUser.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    ZCUserVerifiedTypeNone = -1, // 没有任何认证
    
    ZCUserVerifiedPersonal = 0,  // 个人认证
    
    ZCUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    ZCUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    ZCUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    ZCUserVerifiedDaren = 220 // 微博达人
} ZCUserVerifiedType;
@interface ZCUser : NSObject

/** idstr	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/** name	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;
/** profile_image_url	string	用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 》 2 代表是会员*/
@property (nonatomic, assign) int mbtype;
/** 会员等级*/
@property (nonatomic, assign) int mbrank;
/** vip*/
@property (nonatomic, assign, getter=isVip) BOOL vip;
/** 认证类型*/
@property (nonatomic, assign) ZCUserVerifiedType verified_type;


@end
