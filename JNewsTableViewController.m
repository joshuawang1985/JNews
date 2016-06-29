//
//  JNewsTableViewController.m
//  JNews
//
//  Created by 王昊 on 16/6/8.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JNewsTableViewController.h"
#import "JNetworkTools.h"
#import "JNewsModel.h"
#import "JNewsCell.h"
#import "JPhotoSetVC.h"
#import "JDetailVC.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface JNewsTableViewController ()

@property (strong, nonatomic) NSMutableArray* arrayList;
@property (assign, nonatomic) BOOL updata;

@end

@implementation JNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.delegate = self;
    self.updata = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome) name:@"JAdvertisementKey" object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    if(YES == self.updata)
    {
        [self.tableView.mj_header beginRefreshing];
        self.updata = NO;
    }
}

-(void)welcome
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataWithType:1 andUrl:allUrlstring];
}

- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    //    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,self.arrayList.count];
    [self loadDataWithType:2 andUrl:allUrlstring];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNewsModel *newsModel = self.arrayList[indexPath.row];
    
    NSString *ID = [JNewsCell idForRow:newsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        ID = @"NewsCell";
    }
    
    JNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.NewsModel = newsModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNewsModel* jNewsModel = self.arrayList[indexPath.row];
    CGFloat cellHeight = [JNewsCell heigthOfCell:jNewsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        cellHeight = 80;
    }
    
    return cellHeight;
}

- (void)loadDataWithType:(int) type andUrl:(NSString *)url
{
    [[[JNetworkTools shareNetworkTools]GET:url parameters:self success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray* arryM = [JNewsModel mj_objectArrayWithKeyValuesArray:temArray];
        if (1 == type) {
            self.arrayList = arryM;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
        else if(2 == type)
        {
            [self.arrayList addObjectsFromArray:arryM];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }] resume];
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[JDetailVC class]]) {
        
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        JDetailVC *dc = segue.destinationViewController;
        dc.newsModel = self.arrayList[x];
        dc.index = self.index;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }else
    {
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        JPhotoSetVC * pvc = segue.destinationViewController;
        pvc.newsModel = self.arrayList[x];
    }

    
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
