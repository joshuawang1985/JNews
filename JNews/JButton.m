//
//  JButton.m
//  JNews
//
//  Created by 王昊 on 16/6/6.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JButton.h"
#import "UIView+Frame.h"

@implementation JButton
- (void)setHeight:(CGFloat)height
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 5;
    self.imageView.height = 25;
    self.imageView.width = 25;
    self.imageView.x = (self.width - self.imageView.width)/2.0;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width)/2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    
    self.titleLabel.font = [UIFont fontWithName:@"HYQiHei" size:10];
    self.titleLabel.shadowColor = [UIColor clearColor];
    
    //    self.backgroundColor = [UIColor redColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
     
}
@end
