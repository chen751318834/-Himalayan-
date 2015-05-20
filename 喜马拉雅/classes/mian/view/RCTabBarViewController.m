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
#import "RCCustomizatinTableViewController.h"
#import "RCTabBar.h"
#import "RCDownloadViewController.h"
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

    RCCustomizatinTableViewController * customizationVC  = [[RCCustomizatinTableViewController alloc]init];
    [self addChildViewController:[self setUpChildcController:customizationVC  image:@"tabbar_sound_n" selectedImage:@"tabbar_sound_h"]];

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
