//
//  ZCStatusPhotosView.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/27.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCStatusPhotosView : UIView
/** 图片路径模型数组*/
@property (nonatomic, weak) NSArray *photos;
+ (CGSize)sizeWithPhotosCount:(NSInteger)count;
@end
