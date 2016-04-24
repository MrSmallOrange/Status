//
//  ZCUser.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCUser.h"

@implementation ZCUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}
@end
