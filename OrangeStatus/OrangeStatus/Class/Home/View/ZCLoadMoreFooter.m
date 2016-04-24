//
//  ZCLoadMoreFooter.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/24.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCLoadMoreFooter.h"

@implementation ZCLoadMoreFooter
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZCLoadMoreFooter" owner:nil options:nil] lastObject]; 
}
@end
