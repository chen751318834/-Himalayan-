//
//  RCbasePageViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewController.h"
#import "DMPagerViewController.h"

@interface RCbasePageViewController : RCBaseViewController <DMPagerViewControllerProtocol>
@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;
@end
