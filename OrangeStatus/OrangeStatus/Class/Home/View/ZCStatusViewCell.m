//
//  ZCStatusViewCell.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/24.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusViewCell.h"
#import "ZCStatusFrame.h"
#import "ZCStatus.h"
#import "ZCUser.h"
#import "UIImageView+WebCache.h"
#import "ZCPhoto.h"
#import "ZCStatusToolbar.h"
#import "ZCStatusPhotosView.h"
#import "ZCIconView.h"


@interface ZCStatusViewCell ()
/** 原创微博*/
@property (nonatomic, weak) UIView *originalView;
/** 头像*/
@property (nonatomic, weak) ZCIconView *iconView;
/** 会员图标*/
@property (nonatomic, weak) UIImageView *vipView;
/** 配图*/
@property (nonatomic, weak) ZCStatusPhotosView *photosView;
/** 昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间*/
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源*/
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文内容*/
@property (nonatomic, weak) UILabel *contentLabel;
/** 转发微博整体*/
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文内容*/
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发微博配图*/
@property (nonatomic, weak) ZCStatusPhotosView *retweetPhotosView;
/** 工具条*/
@property (nonatomic, weak) ZCStatusToolbar *toolbar;

@end

@implementation ZCStatusViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ZCStatusViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ZCStatusViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创微博
        [self setupOriginal];
        //初始化转发微博
        [self setupRetweet];
        //初始化工具条
        [self setupToolbar];
    }
    return  self;
}

- (void)setupOriginal
{
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    
    
    ZCIconView *iconView = [[ZCIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    
    ZCStatusPhotosView *photosView = [[ZCStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ZCStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    timeLabel.font = ZCStatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    [sourceLabel sizeToFit];
    sourceLabel.font = ZCStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.font = ZCStatusCellContentFont;
    self.contentLabel = contentLabel;
    
    

}

- (void)setupRetweet
{
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = ZCColor(247, 247, 247);
    self.retweetView = retweetView;
    
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = ZCStatusCellContentFont;
    self.retweetContentLabel = retweetContentLabel;
    
    
    ZCStatusPhotosView *retweetPhotosView = [[ZCStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
    
}

- (void)setupToolbar
{
    ZCStatusToolbar *toolbar = [ZCStatusToolbar toolbar];
                                
    [self.contentView addSubview:toolbar];
    
    self.toolbar = toolbar;
}
- (void)setStatusFrame:(ZCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
  
    ZCStatus *status = statusFrame.status;
    ZCUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewFrame;
    
    self.iconView.frame = statusFrame.iconFrame;
    self.iconView.user = user;
    
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }

    
    if (status.pic_urls.count) {
        
//        ZCPhoto *photo = status.pic_urls[0];
        
        self.photosView.frame = statusFrame.photosViewFrame;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
        
    }else{
        self.photosView.hidden  = YES;
    }
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelFrame) + ZCStatusCellBorderWidth;
    CGSize timeSize = [time sizeWithFont:ZCStatusCellTimeFont];
    self.timeLabel.frame  = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + ZCStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ZCStatusCellSourceFont];
    self.sourceLabel.frame  = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    
    
    
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    
    
    
    //转发微博
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        
        self.retweetView.frame = statusFrame.retweetViewFrame;
        
        ZCStatus *retweeted_status = status.retweeted_status;
        ZCUser *retweeted_status_user = retweeted_status.user;
        
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
        
        
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewFrame;
            self.retweetPhotosView.hidden = NO;
            
        }else{
            self.retweetPhotosView.hidden  = YES;
        }
        
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
    
}

@end
