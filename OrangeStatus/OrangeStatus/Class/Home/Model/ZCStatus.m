//
//  ZCStatus.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatus.h"
#import "ZCUser.h"
#import "MJExtension.h"
#import "ZCPhoto.h"

@implementation ZCStatus
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [ZCPhoto class]};
}

@end
