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
#import "AFNetworking.h"
#import "ZCAccountTool.h"
#import "UIImageView+WebCache.h"
#import "ZCUser.h"
#import "ZCStatus.h"
#import "MJExtension.h"
#import "ZCLoadMoreFooter.h"


@interface ZCHomeController () <ZCDropDownMenuDelegate>
/** 数组的一个元素是一条微博模型*/
@property (nonatomic, strong) NSMutableArray *status;
@end

@implementation ZCHomeController

- (NSMutableArray *)status
{
    if (_status == nil) {
        _status = [NSMutableArray array];
    }
    
    return _status;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self setUserInfo];
    
//    [self loadNewStatus];
    
    //下拉刷新
    [self setupDownRefresh];
    
    //上啦刷新
    [self setupUpRefresh];
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)setupUnreadCount
{
    ZCAccount *account = [ZCAccountTool account];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"access_token"] = account.access_token;
    patameters[@"uid"] = account.uid;
    
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:patameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setupUpRefresh
{
    ZCLoadMoreFooter *footer = [ZCLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;

}

- (void)setupDownRefresh
{
    
    //添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.view addSubview:refreshControl];
    //只有手动刷新才会触发UIControlEventValueChanged事件
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    
    //开始刷新,不会触发UIControlEventValueChanged事件
    [refreshControl beginRefreshing];
    
    //马上加载数据
    [self refreshStateChange:refreshControl];
    
}

- (void)refreshStateChange:(UIRefreshControl *)refreshControl
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ZCAccount *account = [ZCAccountTool account];
    
    //去除最前面的微博
    ZCStatus *firstStatus = [self.status firstObject];
    if (firstStatus) {
        parameters[@"since_id"] = firstStatus.idstr;

    }
    
    parameters[@"access_token"] = account.access_token;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *newStatus = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.status insertObjects:newStatus atIndexes:set];

        
        [self.tableView reloadData];
        
        //结束刷新
        [refreshControl endRefreshing];
        
        //显示最新微博数量
        [self showNewStatusCount:newStatus.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        [refreshControl endRefreshing];
        
    }];
}

- (void)showNewStatusCount:(NSInteger)count
{
    
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    
    if (count == 0) {
        label.text = @"没有新的微博哦";
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条微博", count];
    }
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    
//    [self.navigationController.view addSubview:label];
    label.y = 64 - label.height;
    

    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            
            label.transform = CGAffineTransformIdentity;
            
            
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

- (void)loadNewStatus
{
    
    /*  https://api.weibo.com/2/statuses/friends_timeline.json
     
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     
     
     created_at	string	微博创建时间
     id	int64	微博ID
     mid	int64	微博MID
     idstr	string	字符串型的微博ID
     text	string	微博信息内容
     source	string	微博来源
     favorited	boolean	是否已收藏，true：是，false：否
     truncated	boolean	是否被截断，true：是，false：否
     in_reply_to_status_id	string	（暂未支持）回复ID
     in_reply_to_user_id	string	（暂未支持）回复人UID
     in_reply_to_screen_name	string	（暂未支持）回复人昵称
     thumbnail_pic	string	缩略图片地址，没有时不返回此字段
     bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
     original_pic	string	原始图片地址，没有时不返回此字段
     geo	object	地理信息字段 详细
     user	object	微博作者的用户信息字段 详细
     */
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ZCAccount *account = [ZCAccountTool account];
    parameters[@"access_token"] = account.access_token;
//    parameters[@"count"] = @1;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        

        
        NSArray *newStatus = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.status addObjectsFromArray:newStatus];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
- (void)setUserInfo
{
    
    
    /* https://api.weibo.com/2/users/show.json
     
     
     必选	类型及范围	说明
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     screen_name	false	string	需要查询的用户昵称。
     
     
     id	int64	用户UID
     idstr	string	字符串型的用户UID
     screen_name	string	用户昵称
     name	string	友好显示名称
     province	int	用户所在省级ID
     city	int	用户所在城市ID
     location	string	用户所在地
     description	string	用户个人描述
     url	string	用户博客地址
     profile_image_url	string	用户头像地址（中图），50×50像素
     profile_url	string	用户的微博统一URL地址
     domain	string	用户的个性化域名
     weihao	string	用户的微号
     
     */

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    ZCAccount *account = [ZCAccountTool account];
    
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        ZCUser *user = [ZCUser mj_objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        account.name = user.name;
        [ZCAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 ----%@", error);
    }];
    
}


- (void)setNavigation
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highlightedImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highlightedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop)];
    
    
    
    ZCTitleButton *titleButton = [[ZCTitleButton alloc] init];
    self.navigationItem.titleView = titleButton;
    NSString *name = [ZCAccountTool account].name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.status.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
//    NSDictionary *status = self.status[indexPath.row];
//    NSDictionary *user = status[@"user"];
//    cell.textLabel.text = user[@"name"];
//
//    cell.detailTextLabel.text = status[@"text"];
//    
//    NSString *imageURL = user[@"profile_image_url"];
    
    ZCStatus *status = self.status[indexPath.row];
    ZCUser *user = status.user;
    cell.textLabel.text = user.name;
    
    cell.detailTextLabel.text = status.text;

    
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.status.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
}

- (void)loadMoreStatus
{
    AFHTTPSessionManager *maneger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    
    ZCAccount *account = [ZCAccountTool account];
    
    patameters[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    ZCStatus *lastStatus = [self.status lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        patameters[@"max_id"] = @(maxId);
    }
    

    
    [maneger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:patameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dicArray = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.status addObjectsFromArray:dicArray];
        
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}

@end
