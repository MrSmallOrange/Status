//
//  ZCStatusToolbar.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/25.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCStatus;
@interface ZCStatusToolbar : UIView
+ (instancetype)toolbar;
/** 模型*/
@property (nonatomic, strong) ZCStatus *status;
@end
