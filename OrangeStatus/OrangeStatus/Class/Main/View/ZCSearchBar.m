//
//  ZCSearchBar.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/22.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCSearchBar.h"

@implementation ZCSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入。。。。。";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.width = 30;
        searchIcon.height = 30;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
