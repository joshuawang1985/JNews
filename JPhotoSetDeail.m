//
//  JPhotoSetDeail.m
//  JNews
//
//  Created by 王昊 on 16/6/15.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JPhotoSetDeail.h"

@implementation JPhotoSetDetail

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    JPhotoSetDetail* photoSetDetail = [[JPhotoSetDetail alloc] init];
    [photoSetDetail setValuesForKeysWithDictionary:dict];
    
    return photoSetDetail;
}

@end
