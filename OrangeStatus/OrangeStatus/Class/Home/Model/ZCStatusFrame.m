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
#import "ZCPhoto.h"
#define ZCStatusCellBorderWidth 10
#define ZCStatusCellMargin 15

@implementation ZCStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}

- (void)setStatus:(ZCStatus *)status
{
    _status = status;
    
    ZCUser *user = status.user;
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat iconWH = 35;
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
    self.sourceLabelFrame  = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconFrame), CGRectGetMaxY(self.timeLabelFrame));
    CGFloat maxWidth = cellWidth - 2 * ZCStatusCellBorderWidth;
    CGSize contentSize = [self sizeWithText:status.text font:ZCStatusCellContentFont maxWidth:maxWidth];
    self.contentLabelFrame  = (CGRect){{contentX, contentY}, contentSize};
    
    
    CGFloat originalHeight = 0;
    if (status.pic_urls.count) {
        CGFloat photoWH = 80;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + ZCStatusCellBorderWidth;
        self.photoViewFrame = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalHeight = CGRectGetMaxY(self.photoViewFrame) + ZCStatusCellBorderWidth;
    }else{
        originalHeight = CGRectGetMaxY(self.contentLabelFrame) + ZCStatusCellBorderWidth;
    }
    
    
    CGFloat originalX = 0;
    CGFloat originalY = ZCStatusCellMargin;
    CGFloat originalWidth = cellWidth;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalWidth, originalHeight);
    
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        
        ZCStatus *retweeted_status = status.retweeted_status;
        ZCUser *retweeted_status_user = retweeted_status.user;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        
        CGFloat retweetContentX = ZCStatusCellBorderWidth;
        CGFloat retweetContentY = ZCStatusCellBorderWidth;
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:ZCStatusCellRetweetContentFont maxWidth:maxWidth];
        self.retweetContentLabelFrame  = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        CGFloat retweetViewHeight = 0;
        if (retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotoWH = 50;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelFrame) + ZCStatusCellBorderWidth;
            self.retweetPhotoViewFrame = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
        
            
            
            retweetViewHeight = CGRectGetMaxY(self.retweetPhotoViewFrame) + ZCStatusCellBorderWidth;
        }else{
            retweetViewHeight = CGRectGetMaxY(self.retweetContentLabelFrame) + ZCStatusCellBorderWidth;
        }
        
        //被转发的微博整体
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetViewWidth = cellWidth;
        self.retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewWidth, retweetViewHeight);

        toolbarY = CGRectGetMaxY(self.retweetViewFrame);
        

    }else{
        toolbarY = CGRectGetMaxY(self.originalViewFrame) + 1;
    }
    
    CGFloat toolbarX = 0;
    CGFloat toolbarWidth = cellWidth;
    CGFloat toolbarHeight = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarWidth, toolbarHeight);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);

    
}
@end
