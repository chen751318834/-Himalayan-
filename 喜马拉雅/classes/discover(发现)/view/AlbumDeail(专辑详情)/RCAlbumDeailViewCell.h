//
//  RCAlbumDeailViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTrackList.h"
@interface RCAlbumDeailViewCell : UICollectionViewCell
@property(nonatomic,strong) RCTrackList  *trackList;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end
