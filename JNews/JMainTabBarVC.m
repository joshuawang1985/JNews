//
//  JMainTabBarVC.m
//  JNews
//
//  Created by 王昊 on 16/6/6.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JMainTabBarVC.h"
#import "JTabBarView.h"
#import "JAdManager.h"
#import "UIView+Frame.h"

@interface JMainTabBarVC () <JTabBarDelegate>

@end

@implementation JMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [JAdManager loadLastImageAd];
    if([JAdManager isShouldDisplayAd])
    {
        // Do any additional setup after loading the view.
        UIView* mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIImageView* adView = [[UIImageView alloc] initWithImage:[JAdManager getAdImage]];
        UIImageView* bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adBottom.png"]];
        [mainView addSubview:adView];
        [mainView addSubview:bottomView];
        
        bottomView.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
        adView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
        
        mainView.alpha = 0.99f;
        [self.view addSubview:mainView];
        
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
        
        [UIView animateWithDuration:3 animations:^{
            mainView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication]setStatusBarHidden:NO];
            [UIView animateWithDuration:0.5 animations:^{
                mainView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [mainView removeFromSuperview];
            }];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JAdvertisementKey" object:nil];
        }];
    }


    
    JTabBarView* jTabView = [[JTabBarView alloc] init];
    jTabView.frame = self.tabBar.bounds;
    jTabView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    jTabView.delegate = self;
    
    [jTabView addImageView];

    [jTabView addBarButtonWithNorName:@"tabbar_icon_news_normal" andDisName:@"tabbar_icon_news_highlight" andTitle:@"新闻"];
    [jTabView addBarButtonWithNorName:@"tabbar_icon_reader_normal" andDisName:@"tabbar_icon_reader_highlight" andTitle:@"阅读"];
    [jTabView addBarButtonWithNorName:@"tabbar_icon_media_normal" andDisName:@"tabbar_icon_media_highlight" andTitle:@"视听"];
    [jTabView addBarButtonWithNorName:@"tabbar_icon_found_normal" andDisName:@"tabbar_icon_found_highlight" andTitle:@"发现"];
    [jTabView addBarButtonWithNorName:@"tabbar_icon_me_normal" andDisName:@"tabbar_icon_me_highlight" andTitle:@"我"];
    
    [self.tabBar addSubview:jTabView];
    
    self.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ******************** SXTabBarDelegate代理方法
- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
