//
//  RCPlayerView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPlayerViewController.h"

@interface RCPlayerView : UIView
@property(nonatomic,strong) RCPlayerViewController  *playerVC;
@property(nonatomic,strong) NSNumber  *trackId;
- (void)showAnimationing:(void(^)(void ))animationning completion:(void (^)(void))completion;
- (void)dismissAnimationing:(void(^)(void ))animationning completion:(void (^)(void))completion;
+ (instancetype)playerView;
+ (void)pushViewController:(UIViewController *)viewController;
@end
