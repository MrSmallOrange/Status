//
//  UIBarButtonItem+Extension.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setImage:image forState:UIControlStateNormal];
    [buttonItem setImage:highlightedImage forState:UIControlStateHighlighted];
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [buttonItem sizeToFit];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];
    
    return item;
}

@end
