//
//  JPhotoSetVC.m
//  JNews
//
//  Created by 王昊 on 16/6/15.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JPhotoSetVC.h"
#import "JPhotoSet.h"
#import "JHttpManager.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "JPhotoSetDeail.h"
#import "JReplyVC.h"
#import "JReplyModel.h"

#import <MJExtension.h>

@interface JPhotoSetVC () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *replayBtn;
@property (strong, nonatomic) JPhotoSet* photoset;
@property (strong, nonatomic) IBOutlet UIScrollView *photoScroll;
@property (strong, nonatomic) IBOutlet UITextView *ContentText;
@property (strong, nonatomic) IBOutlet UILabel *lblIndex;

@property(nonatomic,strong) NSMutableArray *replyModels;

@end

@implementation JPhotoSetVC
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (NSMutableArray *)replyModels
{
    if(nil == _replyModels)
    {
        _replyModels = [NSMutableArray array];
    }
    
    return _replyModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    NSString* one = self.newsModel.photosetID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    
    [self.replayBtn setTitle:displayCount forState:UIControlStateNormal];
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    [self sendRequestWithUrl:url];
    
    
    
    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    [self sendRequestWithUrl2:url2];
    
    self.photoScroll.delegate = self;
}

- (void)sendRequestWithUrl:(NSString *)url
{
    [[JHttpManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        JPhotoSet* photoset = [JPhotoSet photoSetWith:responseObject];
        //JPhotoSet* photoset = [JPhotoSet  mj_objectWithKeyValues:responseObject];
        self.photoset = photoset;
        
        [self setLableWithModel:photoset];
        
        [self setimageWithModel:photoset];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
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

- (void)setLableWithModel:(JPhotoSet *)photoset
{
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoset.photos.count];
    self.lblIndex.text = countNum;
    
    [self setContentWithIndex:0];
}

- (void)setimageWithModel:(JPhotoSet *)photoset
{
    NSInteger count = self.photoset.photos.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView* photoImgView =  [[UIImageView alloc] init];
        photoImgView.height = self.photoScroll.height;
        photoImgView.width = self.photoScroll.width;
        photoImgView.y = -64;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeCenter;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        [self.photoScroll addSubview:photoImgView];
    }
    [self setImgWithIndex:0];
    
    self.photoScroll.contentOffset = CGPointZero;
    self.photoScroll.contentSize = CGSizeMake(self.photoScroll.width * count, 0);
    self.photoScroll.showsHorizontalScrollIndicator = NO;
    self.photoScroll.showsVerticalScrollIndicator = NO;
    self.photoScroll.pagingEnabled = YES;
}

- (void)setContentWithIndex:(int)index
{
    NSString *content = [self.photoset.photos[index] note];
    NSString *contentTitle = [self.photoset.photos[index] imgtitle];
    if (content.length != 0) {
        self.ContentText.text = content;
    }else{
        self.ContentText.text = contentTitle;
    }

}

- (void)setImgWithIndex:(int)i
{
    
    UIImageView *photoImgView = nil;
    
    if (i == 0) {
        photoImgView = self.photoScroll.subviews[i+2];
    }else{
        photoImgView = self.photoScroll.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:[self.photoset.photos[i] imgurl]];
    
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
    }
    

    
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


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScroll.contentOffset.x / self.photoScroll.width;
    
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.photoset.photos.count];
    self.lblIndex.text = countNum;
    
    [self setContentWithIndex:index];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JReplyVC*  replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
    
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
