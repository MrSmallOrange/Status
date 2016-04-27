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
#import "ZCStatusPhotosView.h"



@implementation ZCStatusFrame


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
    CGSize nameSize = [user.name sizeWithFont:ZCStatusCellNameFont];
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
    CGSize timeSize = [status.created_at sizeWithFont:ZCStatusCellTimeFont];
    self.timeLabelFrame  = (CGRect){{timeX, timeY}, timeSize};

    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + ZCStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ZCStatusCellSourceFont];
    self.sourceLabelFrame  = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconFrame), CGRectGetMaxY(self.timeLabelFrame));
    CGFloat maxWidth = cellWidth - 2 * ZCStatusCellBorderWidth;
    CGSize contentSize = [status.text sizeWithFont:ZCStatusCellContentFont maxWidth:maxWidth];
    self.contentLabelFrame  = (CGRect){{contentX, contentY}, contentSize};
    
    
    CGFloat originalHeight = 0;
    //设置转发微博配图frame
    if (status.pic_urls.count) {
        
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelFrame) + ZCStatusCellBorderWidth;
        CGSize photosSize = [ZCStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosViewFrame = (CGRect){{photosX, photosY}, photosSize};

        
        originalHeight = CGRectGetMaxY(self.photosViewFrame) + ZCStatusCellBorderWidth;
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
        CGSize retweetContentSize = [retweetContent sizeWithFont:ZCStatusCellRetweetContentFont maxWidth:maxWidth];
        self.retweetContentLabelFrame  = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        CGFloat retweetViewHeight = 0;
        
        
        //设置转发微博配图frame
        if (retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelFrame) + ZCStatusCellBorderWidth;
            CGSize retweetPhotosSize = [ZCStatusPhotosView sizeWithPhotosCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewFrame = (CGRect){{retweetPhotosX, retweetPhotosY}, retweetPhotosSize};

        
            
            
            retweetViewHeight = CGRectGetMaxY(self.retweetPhotosViewFrame) + ZCStatusCellBorderWidth;
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
