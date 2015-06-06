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
#import "RCScrollViewController.h"
#import "RCDownloadAlbumViewController.h"
#import "RCDownloadAudioViewController.h"
#import "RCDownloadingAudioViewController.h"
#import "UIView+AutoLayout.h"
#import "RCDiscoverViewController.h"
#import "RCTabBar.h"
#import "RCSegementControl.h"
#import "RCPlayHistoryViewController.h"
#import "RCDownloadViewController.h"
#import "RCollectViewController.h"
#import "RCPlayListViewController.h"
#import "NTSlidingViewController.h"
#import "RCAttentionViewController.h"
#import "DMPagerViewController.h"
@interface RCTabBarViewController () <RCTabBarDelegate,RCSegementControlDelegate,RCScrollViewControllerDelegate>
@property(nonatomic,weak) RCSegementControl   *segmentControl;
@property(nonatomic,strong) DMPagerViewController  *slidingVC;
@property(nonatomic,strong) RCScrollViewController  *scrollViewVC;
@property(nonatomic,strong) RCScrollViewController  *downLoadScrollViewVC;
@property(nonatomic,weak) RCSegementControl   *downloadSegmentControl;

@end

@implementation RCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRootController];
}


+(void)initialize{


}
- (void)setUpScrollViewController{

    RCSegementControl * control = [[RCSegementControl alloc]init];
    self.segmentControl = control;
    control.delegate = self;
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"关注" forState:UIControlStateNormal];
    [button1 setFont:[UIFont systemFontOfSize:18]];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"收藏" forState:UIControlStateNormal];
    [button2 setFont:[UIFont systemFontOfSize:18]];

    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"历史" forState:UIControlStateNormal];
    [button3 setFont:[UIFont systemFontOfSize:18]];

    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    control.items = @[button1,button2,button3];
    control.backgroundColor = [UIColor clearColor];
    control.selectedSegmentIndex = 0;
    control.frame  = CGRectMake(0, 0, self.view.bounds.size.width, 44);

    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                                      NSForegroundColorAttributeName : [UIColor grayColor]};
    RCPlayHistoryViewController * historyVC = [[RCPlayHistoryViewController alloc]init];
    historyVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"历史" attributes:textAttributes] andIcon:nil];
    historyVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    RCollectViewController * collectVC = [[RCollectViewController alloc]init];

    collectVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"收藏" attributes:textAttributes] andIcon:nil];
    collectVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    RCAttentionViewController * attentionVC = [[RCAttentionViewController alloc]init];
    attentionVC.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"关注" attributes:textAttributes] andIcon:nil];
    attentionVC.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;

    RCScrollViewController * scrollViewVC = [[RCScrollViewController alloc]init];
    self.scrollViewVC = scrollViewVC;	
    scrollViewVC.delegate = self;
    scrollViewVC.viewControllers = @[attentionVC,collectVC,historyVC];
    scrollViewVC.navigationItem.titleView = control;
    RCNavigationController * sldingNavVC = [[RCNavigationController alloc]initWithRootViewController:scrollViewVC];
    [self addChildViewController:sldingNavVC];
    [scrollViewVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_sound_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [scrollViewVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_sound_h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
}
- (void)setUpRootController{
    RCTabBar * tabBar = [[RCTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    tabBar.tabBarDelegate = self;
    RCDiscoverViewController * discoverVC  = [[RCDiscoverViewController alloc]init];
    [self addChildViewController:[self setUpChildcController:discoverVC  image:@"tabbar_find_n" selectedImage:@"tabbar_find_h"]];
    [self setUpScrollViewController];
    [self setUpDownloadViewController];


    RCMeViewController * meVC  = [[RCMeViewController alloc]init];
     [self addChildViewController:[self setUpChildcController:meVC  image:@"tabbar_me_n" selectedImage:@"tabbar_me_h"]];


}
- (void)setUpDownloadViewController{

    RCSegementControl * downloadSegmentControl = [[RCSegementControl alloc]init];
    self.downloadSegmentControl = downloadSegmentControl;
    downloadSegmentControl.delegate = self;
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"声音" forState:UIControlStateNormal];
    [button1 setFont:[UIFont systemFontOfSize:18]];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"专辑" forState:UIControlStateNormal];
    [button2 setFont:[UIFont systemFontOfSize:18]];

    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"正在下载" forState:UIControlStateNormal];
    [button3 setFont:[UIFont systemFontOfSize:18]];

    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    downloadSegmentControl.items = @[button1,button2,button3];
    downloadSegmentControl.backgroundColor = [UIColor clearColor];
    downloadSegmentControl.selectedSegmentIndex = 0;
    downloadSegmentControl.frame  = CGRectMake(0, 0, self.view.bounds.size.width, 44);

    RCDownloadAudioViewController * audioVC = [[RCDownloadAudioViewController alloc]init];
    RCDownloadAlbumViewController * albumVC = [[RCDownloadAlbumViewController alloc]init];
    RCDownloadingAudioViewController * downloadingVC = [[RCDownloadingAudioViewController alloc]init];
    RCScrollViewController * scrollviewVC = [[RCScrollViewController alloc]init];
    scrollviewVC.viewControllers = @[audioVC,albumVC,downloadingVC];
    RCNavigationController * downloadNavVC = [[RCNavigationController alloc]initWithRootViewController:scrollviewVC];
    self.downLoadScrollViewVC = scrollviewVC;
    [self addChildViewController:downloadNavVC];
    scrollviewVC.delegate = self;
    scrollviewVC.navigationItem.titleView = downloadSegmentControl;
    [scrollviewVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_download_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [scrollviewVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_download_h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

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
- (void)segementControl:(RCSegementControl *)segement button:(UIButton *)button from:(NSUInteger)from to:(NSUInteger)to{
    if (segement == self.segmentControl) {
        [self.scrollViewVC scrollToIndex:from animated:YES];
    }else{
        [self.downLoadScrollViewVC scrollToIndex:from animated:YES];
    }
}
- (void)scrollViewController:(RCScrollViewController *)scrollViewController scrollToIndex:(NSUInteger)toIndex{
    if (scrollViewController == self.scrollViewVC) {
        self.segmentControl.selectedSegmentIndex = toIndex;
    }else{
        self.downloadSegmentControl.selectedSegmentIndex = toIndex;
    }

}
@end
