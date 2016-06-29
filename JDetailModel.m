//
//  JDetailModel.m
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JDetailModel.h"
#import "JDetailImgModel.h"

@implementation JDetailModel

/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    JDetailModel *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        JDetailImgModel *imgModel = [JDetailImgModel detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}

@end
