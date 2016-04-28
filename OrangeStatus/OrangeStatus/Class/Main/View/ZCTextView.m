//
//  ZCTextView.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/28.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTextView.h"

@implementation ZCTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        self.placeholderColor = [UIColor grayColor];
    }
    return self;
}

- (void)textDidChange
{
    
    //重新调用drawRect
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
    
}
- (void)drawRect:(CGRect)rect
{
    
    
    if (!self.hasText) {
        
        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        attribute[NSFontAttributeName] = self.font;
        attribute[NSForegroundColorAttributeName] = self.placeholderColor;

        CGFloat x = 5;
        CGFloat y = 8;
        CGFloat w = rect.size.width - 2 * x;
        CGFloat h = rect.size.height - 2 * y;
        CGRect placeholderRect = CGRectMake(x, y, w, h);
        [self.placeholder drawInRect:placeholderRect withAttributes:attribute];
        
    }
 }

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
