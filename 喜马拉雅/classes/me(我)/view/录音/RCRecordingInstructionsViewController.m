//
//  RCRecordingInstructionsViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCRecordingInstructionsViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface RCRecordingInstructionsViewController () <UIScrollViewDelegate>

@end

@implementation RCRecordingInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSUserDefaults standardUserDefaults ] setValue:@(YES) forKey:@"usedInstructions"];

    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.contentSize = CGSizeMake(6*self.view.bounds.size.width, 0);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = self.view.bounds;
    for (int i = 0; i<6; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"record_help_%d",i]];
        [scrollView addSubview:imageView];

    }
    [self.view addSubview:scrollView];
}
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView{


}
@end
