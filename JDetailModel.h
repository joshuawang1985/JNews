//
//  JDetailModel.h
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDetailModel : NSObject

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图(希望这个数组中以后放HMNewsDetailImg模型) */
@property (nonatomic, strong) NSArray *img;

+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
