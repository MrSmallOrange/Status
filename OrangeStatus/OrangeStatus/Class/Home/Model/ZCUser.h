//
//  ZCUser.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUser : NSObject

/** idstr	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/** name	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;
/** profile_image_url	string	用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;


@end
