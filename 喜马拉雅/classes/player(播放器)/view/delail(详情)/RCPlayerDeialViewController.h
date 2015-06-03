//
//  RCPlayerDeialViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewController.h"
#import "ARSegmentPageController.h"
@interface RCPlayerDeialViewController : UITableViewController <ARSegmentControllerDelegate>
@property(nonatomic,strong) NSNumber  *trackId;

@end
