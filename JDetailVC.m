//
//  JDetailVC.m
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JDetailVC.h"
#import "JDetailModel.h"
#import "JDetailImgModel.h"
#import "JHttpManager.h"
#import "JReplyModel.h"
#import "JReplyVC.h"

@interface JDetailVC () <UIWebViewDelegate>
@property(nonatomic,strong) JDetailModel *detailModel;
@property (strong, nonatomic) IBOutlet UIButton *replyCountBtn;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong) NSMutableArray *replyModels;
@property(nonatomic,strong) NSArray *news;

@end

@implementation JDetailVC

- (NSMutableArray *)replyModels
{
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}


- (NSArray *)news
{
    if (_news == nil) {
        _news = [NSArray array];
        _news = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _news;
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    [[JHttpManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
        self.detailModel = [JDetailModel detailWithDict:responseObject[self.newsModel.docid]];
        [self showInWebView];
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        NSLog(@"%@", error);
    }];
    
    NSString *docID = self.newsModel.docid;
    
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }

    
    [self.replyCountBtn setTitle:displayCount forState:UIControlStateNormal];
    
    NSLog(@"%@",self.news[1]);
    NSLog(@"%@----%@",self.newsModel.boardid,docID);
    
    // 假数据
    //    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    
    // 真数据
    NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,docID];
    [self sendRequestWithUrl2:url2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendRequestWithUrl2:(NSString *)url
{
    [[JHttpManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSArray *dictarray = responseObject[@"hotPosts"];
        for (int i = 0; i < dictarray.count; i++) {
            NSDictionary *dict = dictarray[i][@"1"];
            JReplyModel *replyModel = [[JReplyModel alloc]init];
            replyModel.name = dict[@"n"];
            if (replyModel.name == nil) {
                replyModel.name = @"火星网友";
            }
            replyModel.address = dict[@"f"];
            replyModel.say = dict[@"b"];
            replyModel.suppose = dict[@"v"];
            [self.replyModels addObject:replyModel];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - ******************** 拼接html语言
- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"JDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (JDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JReplyVC *replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
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
