//
//  JTabBarView.h
//  JNews
//
//  Created by 王昊 on 16/6/6.
//  Copyright © 2016年 王昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JTabBarDelegate <NSObject>

@optional
- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to;

@end

@interface JTabBarView : UIView

@property (nonatomic,weak) id<JTabBarDelegate> delegate;

- (void)addImageView;
- (void)addBarButtonWithNorName:(NSString *) nor andDisName:(NSString *) dis andTitle:(NSString *) title;
@end
