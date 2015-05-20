//
//  RCTabBar.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//


#import <UIKit/UIKit.h>
@class RCTabBar;
@protocol RCTabBarDelegate <NSObject>

@optional
- (void)tabBarDidPlusButton:(RCTabBar *)tabBar;

@end

@interface RCTabBar : UITabBar

@property(nonatomic,weak) id<RCTabBarDelegate> tabBarDelegate;
@end
