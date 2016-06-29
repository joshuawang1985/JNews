//
//  JDetailImgModel.m
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JDetailImgModel.h"

@implementation JDetailImgModel
/** 便利构造器方法 */
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    JDetailImgModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}
@end
