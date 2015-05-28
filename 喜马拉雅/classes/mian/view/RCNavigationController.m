//
//  RCNavigationController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCNavigationController.h"
#import "RCMeViewController.h"
#import "RCDiscoverViewController.h"
#import "RCDownloadViewController.h"
#import "UIBarButtonItem+MJ.h"
@interface RCNavigationController ()

@end

@implementation RCNavigationController
+ (void)initialize{
    UINavigationBar *  navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem * item  = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = nil;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_back_h" highImage:@"btn_back_n" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back{

    [self popViewControllerAnimated:YES];
}
@end
