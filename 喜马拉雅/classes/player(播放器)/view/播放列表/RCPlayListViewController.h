//
//  RCPlayListViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPlaylist.h"
@interface RCPlayListViewController : UITableViewController
@property(nonatomic,strong) NSArray  *playLists;
@property(nonatomic,strong) RCPlaylist  *playingInfo;
@property(nonatomic,strong) NSNumber  *trackId;
@end
