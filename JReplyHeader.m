//
//  JReplyHeader.m
//  JNews
//
//  Created by 王昊 on 16/6/26.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JReplyHeader.h"

@implementation JReplyHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/** 类方法快速返回热门跟帖的view */
+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"JReplyHeader" owner:nil options:nil];
    return [array firstObject];
}

/** 类方法快速返回最新跟帖的view */
+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"JReplyHeader" owner:nil options:nil];
    return [array lastObject];
}

@end
