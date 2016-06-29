//
//  JDetailVC.h
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNewsModel.h"

@interface JDetailVC : UIViewController

@property(nonatomic,strong) JNewsModel *newsModel;

@property (nonatomic,assign) NSInteger index;

@end
