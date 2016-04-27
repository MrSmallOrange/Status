//
//  ZCStatusPhotosView.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/27.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusPhotosView.h"
#import "ZCPhoto.h"
#import "ZCStatusPhotoView.h"
#define ZCStatusPhotoWH 70
#define ZCStatusPhotoMargin 10
#define ZCStatusPhotoMaxCol(count) ((count == 4 ) ? 2 : 3)

@implementation ZCStatusPhotosView
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = (int)photos.count;
    //创建足够用的ImageView
    while (self.subviews.count < photosCount) {
        ZCStatusPhotoView *photoView = [[ZCStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    //遍历所有图片控件， 设置图片
    for (int i = 0; i < self.subviews.count; i ++) {
        ZCStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.hidden = NO;
            
            
            photoView.photo = photos[i];
            
            
        }else{
            photoView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    int photoCount = (int)self.photos.count;
    
    int macCol = ZCStatusPhotoMaxCol(photoCount);
    
    for (int i = 0; i < photoCount; i++) {
        
        int cols = i % macCol;
        
        CGFloat photoX = cols * (ZCStatusPhotoWH + ZCStatusPhotoMargin);
        
        int rows = i / macCol;
        CGFloat photoY = rows * (ZCStatusPhotoWH + ZCStatusPhotoMargin);
        
        CGFloat photoWidth = ZCStatusPhotoWH;
        CGFloat photoHeight = ZCStatusPhotoWH;
        
        ZCStatusPhotoView *photoView = self.subviews[i];
        photoView.frame = CGRectMake(photoX, photoY, photoWidth, photoHeight);
        
    }
    
}

+ (CGSize)sizeWithPhotosCount:(NSInteger)count
{
    int macCol = ZCStatusPhotoMaxCol(count);

    
    //列数，
    int colsCount = ( count >= macCol) ? macCol : (int)count;
    //行数
    //    int rowsCount = ((int)count - 1) / colsCount + 1;
    int rowsCount  = ((int)count + macCol - 1) / macCol;
    
    
    CGFloat photoWidth = colsCount * ZCStatusPhotoWH + (colsCount - 1) * ZCStatusPhotoMargin;
    CGFloat photoHeight = rowsCount * ZCStatusPhotoWH + (colsCount - 1) * ZCStatusPhotoMargin;
    
    return CGSizeMake(photoWidth, photoHeight);
}
@end
