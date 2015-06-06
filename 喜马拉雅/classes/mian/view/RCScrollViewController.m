//
//  RCScrollViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCScrollViewController.h"
#import "JT3DScrollView.h"
#import "RCConst.h"
@interface RCScrollViewController () <UIScrollViewDelegate>
@property(nonatomic,weak) JT3DScrollView   *scrollView;
@property(nonatomic,assign) NSUInteger from;
@end
@implementation RCScrollViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    JT3DScrollView * scrollView = [[JT3DScrollView alloc]init];
    scrollView.effect =JT3DScrollViewEffectCarousel;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*self.viewControllers.count, 0);
    for (int i = 0; i<self.viewControllers.count; i++) {
        UIViewController * viewController = self.viewControllers[i];
        viewController.view.frame = CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height - 94);
        [scrollView addSubview:viewController.view];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat to =(scrollView.contentOffset.x/scrollView.bounds.size.width);
    for (int i = 0; i<self.viewControllers.count; i++) {
        if (to == i) {
            if ([self.delegate respondsToSelector:@selector(scrollViewController:scrollToIndex:)]) {
                [self.delegate scrollViewController:self scrollToIndex:to];
            }
        }
    }
}
- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated{
    [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*index, -64) animated:animated];
}
@end
