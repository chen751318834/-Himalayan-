//
//  RCPlayerView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerView.h"
#import "RCConst.h"
#import "RCPlayerHeaderView.h"
#import "RCNavigationController.h"
@interface RCPlayerView ()

@end
@implementation RCPlayerView
-  (RCPlayerViewController *)playerVC{
    if (!_playerVC) {
        RCPlayerViewController * playerVC = [[RCPlayerViewController alloc]init];
        playerVC.trackId  = self.trackId;
        self.playerVC = playerVC;
        self.playerVC.view.backgroundColor = [UIColor redColor];
    }
    return _playerVC;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self addSubview:self.playerVC.view];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.playerVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)showAnimationing:(void(^)(void ))animationning completion:(void (^)(void))completion{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;;
        self.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);

        if (animationning) {
            animationning();
        }
    }completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;;

        if (completion) {
            completion();
        }
    }];
}

- (void)dismissAnimationing:(void(^)(void ))animationning completion:(void (^)(void))completion{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;;
        if (animationning) {
            animationning();
        }
    }completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;;
        self.hidden = YES;
        if (completion) {
            completion();
        }

    }];


}
+ (instancetype)playerView{
    NSMutableArray * childViews = [[UIApplication sharedApplication].keyWindow valueForKeyPath:@"subviews"];
    for (id childView in childViews) {
        if ([NSStringFromClass([childView class])isEqualToString:NSStringFromClass([RCPlayerView class]) ]) {
            return childView;
        }
    }
    return nil;
}
+ (void)pushViewController:(UIViewController *)viewController{
    [[RCPlayerView playerView] dismissAnimationing:^{
    } completion:^{
        [[RCNavigationController navigationController] pushViewController:viewController animated:YES];
    }];


}
@end
