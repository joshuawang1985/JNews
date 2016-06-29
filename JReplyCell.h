//
//  JReplyCell.h
//  JNews
//
//  Created by 王昊 on 16/6/24.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JReplyModel.h"

@interface JReplyCell : UITableViewCell

@property (nonatomic, strong) JReplyModel* replyModel;
@property (strong, nonatomic) IBOutlet UILabel *saylable;

@end
