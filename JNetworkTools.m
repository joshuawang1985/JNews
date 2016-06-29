//
//  JNetworkTools.m
//  JNews
//
//  Created by 王昊 on 16/6/7.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import "JNetworkTools.h"

@implementation JNetworkTools

+ (instancetype)shareNetworkTools
{
    static JNetworkTools* instance;
    static dispatch_once_t one_Token;
    
    dispatch_once(&one_Token, ^{
        NSURL* url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    
    return instance;
}


+ (instancetype)shareNetworkToolsWithOutBaseUrl
{
    static JNetworkTools*   instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@""];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

@end
