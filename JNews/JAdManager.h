//
//  JAdManager.h
//  JNews
//
//  Created by 王昊 on 16/6/6.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JAdManager : NSObject
+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLastImageAd;

@end
