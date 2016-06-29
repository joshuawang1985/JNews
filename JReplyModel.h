//
//  JReplyModel.h
//  JNews
//
//  Created by 王昊 on 16/6/24.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JReplyModel : NSObject
/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;

@end
