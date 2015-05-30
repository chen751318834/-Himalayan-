//
//  RCConst.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//
#ifndef _____RCConst_h
#define _____RCConst_h
#ifdef DEBUG
#define RCLog(...) NSLog(__VA_ARGS__)
#else
#define RCLog(...)
#endif

#define RCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RCGlobalBg MTColor(230, 230, 230)
// 随机色
#define RCRandomColor RCColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import <Foundation/Foundation.h>
#import "UIView+Extension.h"
#import "UIView+AutoLayout.h"
#import "UIImage+RC.h"
#import "MJExtension.h"
#import "KVNProgress.h"
#import "Toast+UIView.h"

static NSString * savedAlbumNotification = @"savedAlbumNotifacation";
static NSString * albumNotificationName = @"albumNotificationName";
static NSString * isCollectedAlbumNotificationName = @"isCollectedAlbumNotificationName";


static NSString * backHomeNotification = @"backHomeNotification";

static NSString * selectedSegmentControlIndexNotification = @"selectedSegmentControlIndexNotification";
static NSString * selectedSegmentControlIndexNotificationName = @"selectedSegmentControlIndexNotificationName";

#define RCNotificationCenter  [NSNotificationCenter defaultCenter]

#endif
