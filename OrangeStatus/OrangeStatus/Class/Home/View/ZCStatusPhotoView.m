//
//  ZCStatusPhotoView.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/27.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCStatusPhotoView.h"
#import "ZCPhoto.h"
#import "UIImageView+WebCache.h"


@interface ZCStatusPhotoView ()
/** gif*/
@property (nonatomic, weak) UIImageView *gifImageView;
@end

@implementation ZCStatusPhotoView

- (UIImageView *)gifImageView
{
    if (_gifImageView == nil) {
        UIImage *gifImage = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifImageView = [[UIImageView alloc] initWithImage:gifImage];
        [self addSubview:gifImageView];
        _gifImageView = gifImageView;
    }
    
    return _gifImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setPhoto:(ZCPhoto *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifImageView.hidden = NO;
    }else{
        self.gifImageView.hidden = YES;
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifImageView.x = self.width - self.gifImageView.width;
    self.gifImageView.y = self.height - self.gifImageView.height;
}
@end
