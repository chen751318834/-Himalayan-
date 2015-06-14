//
//  RCRecordingInstructionsViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCRecordingInstructionsViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "RCBottomPlayerButton.h"
#import "RCConst.h"
#import "RCRecordingViewController.h"
@interface RCRecordingInstructionsViewController () <UIScrollViewDelegate>
@property(nonatomic,weak) UIPageControl   *pageControl;

@end

@implementation RCRecordingInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RCBottomPlayerButton playingAudioButton] moveToBottom];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //UIScrollView

    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.contentSize = CGSizeMake(6*self.view.bounds.size.width, 0);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = self.view.bounds;
    for (int i = 0; i<6; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, -20, self.view.bounds.size.width, self.view.bounds.size.height+20)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"record_help_%d",i]];
        [scrollView addSubview:imageView];

    }
    [self.view addSubview:scrollView];

    //UiPageControl
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:pageControl];
    [pageControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 20, 0) excludingEdge:ALEdgeTop];
    [pageControl autoSetDimension:ALDimensionHeight toSize:20];
    pageControl.numberOfPages = 6;
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView{
    int curentPage = (int)((scrollView.contentOffset.x/scrollView.bounds.size.width) +0.5);
  [UIView animateWithDuration:0.25 animations:^{
      self.pageControl.currentPage = curentPage;
  }];

}
@end
