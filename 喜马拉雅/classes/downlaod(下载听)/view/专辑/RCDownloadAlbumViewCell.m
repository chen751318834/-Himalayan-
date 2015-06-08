//
//  RCDownloadAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAlbumViewCell.h"
#import "UIImageView+WebCache.h"

@interface RCDownloadAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *albumCountLabel;

@end
@implementation RCDownloadAlbumViewCell
- (void)setList:(RCTrackList *)list{
    _list = list;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.titlelabel.text = list.albumTitle;
    self.albumCountLabel.text = [NSString stringWithFormat:@"%ld个下载",(unsigned long)list.audioCount +1];
}
@end
