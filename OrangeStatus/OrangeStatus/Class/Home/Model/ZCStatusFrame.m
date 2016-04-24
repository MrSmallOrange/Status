//
//  ZCStatusFrame.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/24.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusFrame.h"
#import "ZCUser.h"
#import "ZCStatus.h"
#define ZCStatusCellBorderWidth 10

@implementation ZCStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attribute];
    
    
}

- (void)setStatus:(ZCStatus *)status
{
    _status = status;
    
    ZCUser *user = status.user;
    
    CGFloat iconWH = 50;
    CGFloat iconX = ZCStatusCellBorderWidth;
    CGFloat iconY = ZCStatusCellBorderWidth;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + ZCStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:ZCStatusCellNameFont];
    self.nameLabelFrame  = (CGRect){{nameX, nameY}, nameSize};
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + ZCStatusCellBorderWidth;
        CGFloat vipY = nameY;
        CGFloat vipWith = 14;
        CGFloat vipHeiht = nameSize.height;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipWith, vipHeiht);
    }
    
    
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame) + ZCStatusCellBorderWidth;
    CGSize timeSize = [self sizeWithText:status.created_at font:ZCStatusCellTimeFont];
    self.timeLabelFrame  = (CGRect){{timeX, timeY}, timeSize};

    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + ZCStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:ZCStatusCellSourceFont];
    self.timeLabelFrame  = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    self.cellHeight = 70;
}
@end
