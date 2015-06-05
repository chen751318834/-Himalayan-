//
//  RCPlayerViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/31.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentPageController.h"
@interface RCPlayerViewController : ARSegmentPageController
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *albumId;
@end
