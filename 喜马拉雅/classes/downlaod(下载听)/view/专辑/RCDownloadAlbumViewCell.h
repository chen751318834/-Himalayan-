//
//  RCDownloadAlbumViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTrackList.h"
@interface RCDownloadAlbumViewCell : UITableViewCell
@property(nonatomic,strong) RCTrackList  *list;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
