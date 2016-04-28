//
//  ZCComposeToolBar.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/28.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ZCComposeToolBarTypeCamere,     //相机
    ZCComposeToolBarTypePicture,    //相册
    ZCComposeToolBarTypeMention,   //@
    ZCComposeToolBarTypeTrend,     //#
    ZCComposeToolBarTypeEmotion    //表情
} ZCComposeToolBarType;

@class ZCComposeToolBar;

@protocol ZCComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(ZCComposeToolBar *)toolBar didButtonType:(ZCComposeToolBarType)type;

@end

@interface ZCComposeToolBar : UIView

/** daili*/
@property (nonatomic, weak) id<ZCComposeToolBarDelegate> delegate;

@end
