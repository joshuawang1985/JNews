//
//  JPhotoSet.m
//  JNews
//
//  Created by 王昊 on 16/6/15.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JPhotoSet.h"
#import "JPhotoSetDeail.h"

@implementation JPhotoSet

+ (instancetype)photoSetWith:(NSDictionary *)dict
{
    JPhotoSet* jPhoto = [[JPhotoSet alloc] init];
    [jPhoto setValuesForKeysWithDictionary:dict];
    
    NSArray* photoarray = jPhoto.photos;
    NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:photoarray.count];
    
    
    for (NSDictionary* dic in photoarray) {
        JPhotoSetDetail* photoDetail = [JPhotoSetDetail photoDetailWithDict:dic];
        [tempArray addObject:photoDetail];
    }
    
    jPhoto.photos = tempArray;
    
    
    return jPhoto;
}

@end
