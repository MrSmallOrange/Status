//
//  ZCDropDownMenu.h
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/22.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCDropDownMenu;

@protocol  ZCDropDownMenuDelegate <NSObject>

@optional

- (void)dropDownMenuDidDismiss:(ZCDropDownMenu *)menu;
- (void)dropDownMenuDidShow:(ZCDropDownMenu *)menu;

@end


@interface ZCDropDownMenu : UIView

+ (instancetype)menu;
- (void)showFromView:(UIView *)fromView;
- (void)dimiss;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, weak) id<ZCDropDownMenuDelegate> delegate;

@end
