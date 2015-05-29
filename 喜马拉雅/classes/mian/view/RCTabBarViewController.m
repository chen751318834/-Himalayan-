//
//  RCTabBarViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCTabBarViewController.h"
#import "RCNavigationController.h"
#import "RCMeViewController.h"
#import "RCTabBar.h"
#import "RCDiscoverViewController.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RCTabBar.h"
#import "RCDownloadViewController.h"
#import "RCollectViewController.h"
#import "RCHistoryViewController.h"
#import "NTSlidingViewController.h"
#import "RCAttentionViewController.h"
#import "DMPagerViewController.h"
@interface RCTabBarViewController () <RCTabBarDelegate>

@end

@implementation RCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRootController];
}


+(void)initialize{



}

- (void)setUpRootController{
    RCTabBar * tabBar = [[RCTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    tabBar.tabBarDelegate = self;

    RCDiscoverViewController * discoverVC  = [[RCDiscoverViewController alloc]init];
    [self addChildViewController:[self setUpChildcController:discoverVC  image:@"tabbar_find_n" selectedImage:@"tabbar_find_h"]];

    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                                      NSForegroundColorAttributeName : [UIColor grayColor]};
    RCHistoryViewController * historyVC = [[RCHistoryViewController alloc]init];
    historyVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"历史" attributes:textAttributes] andIcon:nil];
    historyVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    RCollectViewController * collectVC = [[RCollectViewController alloc]init];

    collectVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"收藏" attributes:textAttributes] andIcon:nil];
    collectVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    RCAttentionViewController * attentionVC = [[RCAttentionViewController alloc]init];
    attentionVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"关注" attributes:textAttributes] andIcon:nil];
    attentionVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    DMPagerViewController * slidingVC = [[DMPagerViewController alloc]initWithViewControllers:@[attentionVC,collectVC,historyVC]];
    slidingVC.animation = DMPagerViewControllerAnimationBounceStartEnd;
    slidingVC.navigationBarHeight = 30;
    slidingVC.navigationBar.style = DMPagerNavigationBarStyleFar;
    slidingVC.navigationBar.colorizeMode = DMPagerNavigationBarItemColorizeWithFade;
    UIColor *activeColor = [UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
    UIColor *inactiveColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1.0];
    slidingVC.navigationBar.inactiveItemColor = inactiveColor;
    slidingVC.navigationBar.activeItemColor = activeColor;

    [self addChildViewController:slidingVC];

    [slidingVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_sound_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [slidingVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_sound_h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    RCDownloadViewController * downloadVC  = [[RCDownloadViewController alloc]init];
    [self addChildViewController:[self setUpChildcController:downloadVC  image:@"tabbar_download_n" selectedImage:@"tabbar_download_h"]];

    RCMeViewController * meVC  = [[RCMeViewController alloc]init];
     [self addChildViewController:[self setUpChildcController:meVC  image:@"tabbar_me_n" selectedImage:@"tabbar_me_h"]];


}
- (RCNavigationController *)setUpChildcController:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage{

    [vc.tabBarItem setImage:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    RCNavigationController * navVC = [[RCNavigationController alloc]initWithRootViewController:vc];

    return navVC;
}
#pragma mark - RCTabBarDelegate
- (void)tabBarDidPlusButton:(RCTabBar *)tabBar{

}
@end
