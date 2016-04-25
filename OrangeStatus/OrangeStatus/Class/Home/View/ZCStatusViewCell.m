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

@interface ZCStatusViewCell ()
/** 原创微博*/
@property (nonatomic, weak) UIView *originalView;
/** 头像*/
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标*/
@property (nonatomic, weak) UIImageView *vipView;
/** 配图*/
@property (nonatomic, weak) UIImageView *photoView;
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
@property (nonatomic, weak) UIImageView *retweetPhotoView;

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
        
        //初始化原创微博
        [self setupOriginal];
        //初始化转发微博
        [self setupRetweet];
    }
    return  self;
}

- (void)setupOriginal
{
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    
    UIImageView *photoView = [[UIImageView alloc] init];
    [originalView addSubview:photoView];
    photoView.backgroundColor = [UIColor redColor];
    self.photoView = photoView;
    
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ZCStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = ZCStatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = ZCStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor blueColor];
    contentLabel.font = ZCStatusCellContentFont;
    self.contentLabel = contentLabel;
    
    

}

- (void)setupRetweet
{
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.backgroundColor = [UIColor redColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = ZCStatusCellContentFont;
    self.retweetContentLabel = retweetContentLabel;
    
    
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
    
}
- (void)setStatusFrame:(ZCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
  
    ZCStatus *status = statusFrame.status;
    ZCUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewFrame;
    
    self.iconView.frame = statusFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    
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
        
        ZCPhoto *photo = status.pic_urls[0];
        
        self.photoView.frame = statusFrame.photoViewFrame;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
        
    }else{
        self.photoView.hidden  = YES;
    }
    

    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    
    
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    
    
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    
    
    
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
        NSLog(@"%@", retweetContent);
        if (retweeted_status.pic_urls.count) {
            
            ZCPhoto *photo = retweeted_status.pic_urls[0];
            
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewFrame;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.hidden = NO;
            
        }else{
            self.retweetPhotoView.hidden  = YES;
        }
        
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    
    
}

@end
