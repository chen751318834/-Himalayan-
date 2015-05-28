//
//  RCbasePageViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCbasePageViewController.h"

@interface RCbasePageViewController ()

@end

@implementation RCbasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:CGRectZero];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.view.backgroundColor = aBkgColor;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = aText;
        label.font = [UIFont boldSystemFontOfSize:40];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleTopMargin    |
                                  UIViewAutoresizingFlexibleBottomMargin);
        [self.view addSubview:label];

        CGSize bestSize = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                             options:NSStringDrawingTruncatesLastVisibleLine
                                                             context:NULL].size;
        label.frame = CGRectMake(0,
                                 ((CGRectGetHeight(self.view.frame)-bestSize.height)/2.0f),
                                 CGRectGetWidth(self.view.frame),
                                 bestSize.height);

    }
    return self;
}

- (DMPagerNavigationBarItem *)pagerItem {
    return self.pagerObj;
}
@end
