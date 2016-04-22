//
//  ZCHomeController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCHomeController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZCTitleButton.h"
#import "ZCDropDownMenu.h"


@interface ZCHomeController () <ZCDropDownMenuDelegate>

@end

@implementation ZCHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highlightedImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highlightedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop)];
    
    
    ZCTitleButton *titleButton = [[ZCTitleButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;

    
}
#pragma mark - Title Button Target 
- (void)clickTitle:(UIButton *)titleButton
{
    ZCDropDownMenu *menu = [ZCDropDownMenu menu];
    menu.delegate = self;
    menu.contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStyleGrouped];
    
    [menu showFromView:titleButton];
}

#pragma mark - BarButtonItem Target 
- (void)friendSearch
{
    
}

- (void)pop
{
    
}

#pragma mark - ZCDropDownMenuDelegate
- (void)dropDownMenuDidDismiss:(ZCDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

- (void)dropDownMenuDidShow:(ZCDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
