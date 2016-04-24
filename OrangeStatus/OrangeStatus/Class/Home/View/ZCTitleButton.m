//
//  ZCTitleButton.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/21.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTitleButton.h"
#define ZCMargin 10

//@interface ZCTitleButton ()
//@property (nonatomic, assign) CGFloat imageViewX;
//@end

@implementation ZCTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];


//        self.backgroundColor = [UIColor grayColor];
        
    }
    
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    

//    self.titleLabel.x = self.imageView.x;
    
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
 

    self.titleLabel.x = 0;

    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + ZCMargin;
    

}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
//- (void)setFrame:(CGRect)frame
//{
//    frame.size.width += ZCMargin;
//    [super setFrame:frame];
//}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];

}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
    
//    self.imageViewX = self.imageView.x;

}

@end
