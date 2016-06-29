//
//  JTabBarView.m
//  JNews
//
//  Created by 王昊 on 16/6/6.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JTabBarView.h"
#import "JButton.h"


@interface JTabBarView ()

@property (nonatomic, strong) JButton*  selBtn; //保存上一次点击按钮的对象;
@property (nonatomic, strong) UIImageView*  imgView;

@end

@implementation JTabBarView

-(void)layoutSubviews
{
    UIImageView* imgView = self.subviews[0];
    imgView.frame = self.bounds;
    
    for(int i = 1; i < self.subviews.count; i++)
    {
        JButton* btn = self.subviews[i];
        
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/5;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);

        btn.tag = i - 1;
    }
}

- (void)addImageView
{
    UIImageView* imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@""];
    self.imgView = imgView;
    [self addSubview:imgView];
}

#pragma mark - /****************addBarButtonWithNorName*****************/
- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andTitle:(NSString *)title
{
    JButton* jbtn = [[JButton alloc] init];
    
    [jbtn setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [jbtn setImage:[UIImage imageNamed:dis] forState:UIControlStateDisabled];
    
    [jbtn setTitle:title forState:UIControlStateNormal];
    [jbtn setTitleColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
    [jbtn setTitleColor:[UIColor colorWithRed:183/255.0 green:20/255.0 blue:28/255.0 alpha:1] forState:UIControlStateDisabled];
    
    [jbtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:jbtn];
    
    if(self.subviews.count == 2)
    {
        jbtn.tag = 1;
        [self btnclick:jbtn];
    }

    
}


-(void)btnclick:(JButton *)btn
{
    if([self.delegate respondsToSelector:@selector(ChangSelIndexForm:to:)])
    {
        [self.delegate ChangSelIndexForm:_selBtn.tag to:btn.tag];
    }
    _selBtn.enabled = YES;
    _selBtn = btn;
    btn.enabled = NO;
}
@end
