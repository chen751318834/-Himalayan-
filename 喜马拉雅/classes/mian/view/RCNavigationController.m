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
#import "RCCustomizatinTableViewController.h"
#import "RCDownloadViewController.h"
@interface RCNavigationController ()

@end

@implementation RCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildControllers];
}
+ (void)initialize{


}
- (void)setUpChildControllers{



}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;

    }
    [super pushViewController:viewController animated:animated];
}
@end
