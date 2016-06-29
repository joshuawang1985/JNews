//
//  JHttpManager.m
//  JNews
//
//  Created by 王昊 on 16/6/15.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JHttpManager.h"

@implementation JHttpManager

+(instancetype)manager
{
    JHttpManager* mgr = [super manager];
    
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
