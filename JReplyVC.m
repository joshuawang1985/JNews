//
//  JReplyVC.m
//  JNews
//
//  Created by 王昊 on 16/6/24.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JReplyVC.h"
#import "JReplyCell.h"
#import "JReplyModel.h"
#import "JReplyHeader.h"

@interface JReplyVC () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tv;

@end

@implementation JReplyVC

static NSString *ID = @"replyCell";

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.tv.delegate = self;
    //self.tv.dataSource = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.replys.count == 0) {
        return 1;
    }
    
    if (section == 0) {
        return self.replys.count;
    }else{
        return self.replys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.replys.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     暂无跟帖数据";
        return cell2;
    }else{
        JReplyModel *model = self.replys[indexPath.row];
        cell.replyModel = model;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [JReplyHeader replyViewFirst];
    }else{
        return [JReplyHeader replyViewLast];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.replys.count == 0){
        return 40;
    }else{
        JReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        JReplyModel *model = self.replys[indexPath.row];
        
        cell.replyModel = model;
        
        [cell layoutIfNeeded];
        CGSize size = [cell.saylable systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return cell.saylable.frame.origin.y + size.height + 10;
    }

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
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
