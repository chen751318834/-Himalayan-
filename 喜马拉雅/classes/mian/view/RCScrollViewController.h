//
//  RCScrollViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCScrollViewController;
@protocol RCScrollViewControllerDelegate <NSObject>
@optional
-  (void)scrollViewController:(RCScrollViewController *)scrollViewController  scrollToIndex:(NSUInteger)toIndex;
@end
@interface RCScrollViewController : UIViewController
@property(nonatomic,strong) NSArray  *viewControllers;
@property(nonatomic,weak) id<RCScrollViewControllerDelegate>  delegate;
- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated;
@end
