//
//  JNewsCell.h
//  JNews
//
//  Created by 王昊 on 16/6/10.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNewsModel.h"

@interface JNewsCell : UITableViewCell

@property (strong, nonatomic)JNewsModel* NewsModel;

+ (NSString *)idForRow:(JNewsModel *)NewsModel;
+ (CGFloat)heigthOfCell:(JNewsModel *)NewsModel;

@end
