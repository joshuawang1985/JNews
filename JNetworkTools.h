//
//  JNetworkTools.h
//  JNews
//
//  Created by 王昊 on 16/6/7.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JNetworkTools : AFHTTPSessionManager
+ (instancetype)shareNetworkTools;
+ (instancetype)shareNetworkToolsWithOutBaseUrl;

@end
