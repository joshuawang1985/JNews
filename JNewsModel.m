//
//  JNewsModel.m
//  JNews
//
//  Created by 王昊 on 16/6/10.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JNewsModel.h"

@implementation JNewsModel

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    JNewsModel* model = [[JNewsModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
