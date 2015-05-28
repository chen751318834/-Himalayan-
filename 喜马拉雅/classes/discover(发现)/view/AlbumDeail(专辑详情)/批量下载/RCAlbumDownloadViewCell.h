//
//  RCAlbumDownloadViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTrackList.h"
@interface RCAlbumDownloadViewCell : UITableViewCell
@property(nonatomic,strong) RCTrackList  *list;
+(instancetype)cell;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@end
