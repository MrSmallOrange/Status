//
//  ZCStatusViewCell.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/24.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCStatusFrame;

@interface ZCStatusViewCell : UITableViewCell

/** 强大的数据模型*/
@property (nonatomic, strong) ZCStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
