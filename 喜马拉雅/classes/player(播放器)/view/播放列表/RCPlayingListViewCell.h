//
//  RCPlayListViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPlaylist.h"
@interface RCPlayingListViewCell : UITableViewCell
@property(nonatomic,strong) RCPlaylist  *list;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
+ (instancetype)cell;
@end
