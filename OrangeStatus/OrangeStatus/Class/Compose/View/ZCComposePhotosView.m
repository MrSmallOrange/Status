//
//  ZCComposePhotosView.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/28.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCComposePhotosView.h"

@implementation ZCComposePhotosView
- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageViewWH = 70;
    CGFloat imageViewMargin = 10;
    
    for (int i = 0; i < count; i ++) {
        UIImageView *imageView = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        
        imageView.x = col * (imageViewWH + imageViewMargin);
        imageView.y = row * (imageViewWH + imageViewMargin);
        imageView.width = imageViewWH;
        imageView.height = imageViewWH;
    }
}
@end
