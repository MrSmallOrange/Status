//
//  ZCStatusFrame.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/24.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
////  一个HWStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus


#import <Foundation/Foundation.h>
#define ZCStatusCellNameFont [UIFont systemFontOfSize:15]
#define ZCStatusCellTimeFont [UIFont systemFontOfSize:12]
#define ZCStatusCellSourceFont [UIFont systemFontOfSize:12]
#define ZCStatusCellContentFont [UIFont systemFontOfSize:15]
#define ZCStatusCellRetweetContentFont [UIFont systemFontOfSize:12]
#define ZCStatusCellBorderWidth 10
#define ZCStatusCellMargin 15

@class ZCStatus;

@interface ZCStatusFrame : NSObject
/** 微博模型*/
@property (nonatomic, strong) ZCStatus *status;
/** 原创微博*/
@property (nonatomic, assign) CGRect originalViewFrame;
/** 头像*/
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标*/
@property (nonatomic, assign) CGRect vipViewFrame;
/** 配图*/
@property (nonatomic, assign) CGRect photosViewFrame;
/** 昵称*/
@property (nonatomic, assign) CGRect nameLabelFrame;
/** 时间*/
@property (nonatomic, assign) CGRect timeLabelFrame;
/** 来源*/
@property (nonatomic, assign) CGRect sourceLabelFrame;
/** 正文内容*/
@property (nonatomic, assign) CGRect contentLabelFrame;
/** cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/** 转发微博整体*/
@property (nonatomic, assign) CGRect retweetViewFrame;
/** 转发微博正文内容*/
@property (nonatomic, assign) CGRect retweetContentLabelFrame;
/** 转发微博配图*/
@property (nonatomic, assign) CGRect retweetPhotosViewFrame;
/** 工具条*/
@property (nonatomic, assign) CGRect toolbarFrame;
@end
