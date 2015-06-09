//
//  RCDownloadAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAlbumViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCDownloadTool.h"
@interface RCDownloadAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *albumCountLabel;

@end
@implementation RCDownloadAlbumViewCell
+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCDownloadAlbumViewCell" owner:nil options:nil]lastObject];
}
- (void)setList:(RCTrackList *)list{
    _list = list;
    if (self.isLcoalAlbum) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
        self.titlelabel.text = list.albumTitle;
        self.albumCountLabel.text = [NSString stringWithFormat:@"%lu个下载",(unsigned long)[RCDownloadTool downloadAudiosWithAlbumId:list.albumId].count];
        [self.deleteButton setImage:[UIImage imageNamed:@"btn_downloadalbum_delete_n"] forState:UIControlStateNormal];

    }else{
        [self.iconView setImage:[UIImage imageNamed:@"finditem_zone"]];
        [self.deleteButton setImage:[UIImage imageNamed:@"icon_filter_arrow"] forState:UIControlStateNormal];
        self.titlelabel.text = @"热门下载推荐";
        self.albumCountLabel.text = @"每日更新";
  }

}

@end
