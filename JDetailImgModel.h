//
//  JDetailImgModel.h
//  JNews
//
//  Created by 王昊 on 16/6/27.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDetailImgModel : NSObject

@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;

+ (instancetype)detailImgWithDict:(NSDictionary *)dict;

@end
