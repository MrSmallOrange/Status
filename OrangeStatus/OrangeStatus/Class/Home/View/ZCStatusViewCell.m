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
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        
        UIImageView *vipView = [[UIImageView alloc] init];
        [self.contentView addSubview:vipView];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        
        
        UIImageView *photoView = [[UIImageView alloc] init];
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        
        
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = ZCStatusCellNameFont;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        timeLabel.font = ZCStatusCellTimeFont;
        self.timeLabel = timeLabel;
        
        
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = ZCStatusCellSourceFont;
        [self.contentView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        
    }
    return  self;
}

- (void)setStatusFrame:(ZCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
  
    ZCStatus *status = statusFrame.status;
    ZCUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewFrame;
    
    self.iconView.frame = statusFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    self.vipView.frame = statusFrame.vipViewFrame;
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level6"];
    
    self.photoView.frame = statusFrame.photoViewFrame;
    self.photoView.backgroundColor  = [UIColor redColor];
    
    self.nameLabel.text = user.name;
    
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    
    
    
    
    
}

@end
