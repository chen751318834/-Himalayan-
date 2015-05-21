//
//  RCBaseViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBaseViewController : UITableViewController
- (void)loadNewData;
- (void)loadMoreData;

/**
 *  正文的数组
 */
@property(nonatomic,strong) NSMutableArray  *contents;
@end
