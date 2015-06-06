//
//  RCDownloadViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCDownloadViewController.h"
#import "RCDownloadAlbumViewController.h"
#import "RCDownloadAudioViewController.h"
#import "RCDownloadingAudioViewController.h"
#import "RCNavigationController.h"
#import "RCScrollViewController.h"
#import "RCSegementControl.h"
@interface RCDownloadViewController () <RCSegementControlDelegate,RCScrollViewControllerDelegate>
@property(nonatomic,strong) RCScrollViewController  *downloadScrollViewController;
@property (weak, nonatomic) IBOutlet RCSegementControl *downloadSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation RCDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDownloadViewController];
}

- (void)setUpDownloadViewController{


    self.downloadSegmentControl.delegate = self;
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
    self.downloadSegmentControl.items = @[button1,button2,button3];
    self.downloadSegmentControl.backgroundColor = [UIColor clearColor];
    self.downloadSegmentControl.selectedSegmentIndex = 0;
    self.downloadSegmentControl.frame  = CGRectMake(0, 0, self.view.bounds.size.width, 44);

    RCDownloadAudioViewController * audioVC = [[RCDownloadAudioViewController alloc]init];
    RCDownloadAlbumViewController * albumVC = [[RCDownloadAlbumViewController alloc]init];
    RCDownloadingAudioViewController * downloadingVC = [[RCDownloadingAudioViewController alloc]init];
    RCScrollViewController * scrollviewVC = [[RCScrollViewController alloc]init];
    scrollviewVC.viewControllers = @[audioVC,albumVC,downloadingVC];
    self.downloadScrollViewController = scrollviewVC;
    scrollviewVC.view.frame = self.contentView.bounds;
    scrollviewVC.delegate = self;
//    [scrollviewVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_download_n"]];
//    [scrollviewVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_download_h"]];
    [self addChildViewController:downloadingVC];
    [self.contentView addSubview:downloadingVC.view];
}
- (void)segementControl:(RCSegementControl *)segement button:(UIButton *)button from:(NSUInteger)from to:(NSUInteger)to{
    [self.downloadScrollViewController scrollToIndex:from animated:YES];
}

- (void)scrollViewController:(RCScrollViewController *)scrollViewController scrollToIndex:(NSUInteger)toIndex{
    self.downloadSegmentControl.selectedSegmentIndex = toIndex;
    
}
@end
