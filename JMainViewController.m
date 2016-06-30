//
//  JMainViewController.m
//  JNews
//
//  Created by 王昊 on 16/6/7.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JMainViewController.h"
#import "JTitleLabel.h"
#import "JNewsTableViewController.h"
#import "UIView+Frame.h"

@interface JMainViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;

@property (strong, nonatomic) UIButton* rightItem;
@property (strong, nonatomic) NSArray* arrayList;

@property(nonatomic,assign,getter=isWeatherShow)BOOL weatherShow;


@end

@implementation JMainViewController

- (NSArray *)arrayList
{
    if(nil == _arrayList)
    {
        _arrayList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil ]];
    }
    return _arrayList;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.rightItem.hidden = NO;
    self.rightItem.transform = CGAffineTransformIdentity;
    [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.bigScrollView.delegate = self;
    
    [self addController];
    [self addLable];
    
    CGFloat fx = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(fx, 0);
    
    UIViewController* vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView  addSubview:vc.view];
    
    UIButton* rightItem = [[UIButton alloc] init];
    self.rightItem = rightItem;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    //[win addSubview:rightItem];
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightItem.y = 20;
    rightItem.width = 45;
    rightItem.height = 45;
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    [rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];

}

- (void)rightItemClick
{
    if (self.isWeatherShow) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI * 5);
            
        } completion:^(BOOL finished) {
            [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
    }else{
        
        [self.rightItem setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.2 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI );
            }];
        }];
    }
    self.weatherShow = !self.isWeatherShow;
}

- (void)addController
{
    for(int i = 0; i < self.arrayList.count; i++)
    {
        JNewsTableViewController* newsVC = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        newsVC.title = self.arrayList[i][@"title"];
        newsVC.urlString = self.arrayList[i][@"urlString"];
        
        [self addChildViewController:newsVC];
    }
}

- (void)addLable
{
    for(int i = 0; i < 8; i++)
    {
        CGFloat fHeight = 40;
        CGFloat fWidth = 70;
        CGFloat fy = 0;
        CGFloat fx = i * fWidth;
        UIViewController* vc = self.childViewControllers[i];
        JTitleLabel* lbl = [[JTitleLabel alloc] init];
        lbl.frame = CGRectMake(fx, fy, fWidth, fHeight);
        lbl.font = [UIFont fontWithName:@"HYQiHei" size:16];
        lbl.text = vc.title;
        [self.smallScrollView addSubview:lbl];
        lbl.tag = i;
        lbl.userInteractionEnabled = YES;
        [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
    }
    
    self.smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
}

- (void) lblClick:(UITapGestureRecognizer *) recingizer
{
    JTitleLabel* lbl = (JTitleLabel *)recingizer.view;
    CGFloat offsetX = lbl.tag * self.bigScrollView.frame.size.width;
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
}

#pragma mark ************UISCROLLVIEWDELAGETE************

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    JTitleLabel* jtitleLbl = (JTitleLabel *) self.smallScrollView.subviews[index];
    
    CGFloat offsetx = jtitleLbl.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    
    // 添加控制器
    JNewsTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            JTitleLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    JTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        JTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }}






















@end
