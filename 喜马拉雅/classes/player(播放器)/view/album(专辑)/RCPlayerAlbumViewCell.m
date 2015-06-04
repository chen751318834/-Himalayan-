//
//  RCPlayerAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerAlbumViewCell.h"
#import "UIImageView+WebCache.h"

@interface RCPlayerAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *zuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation RCPlayerAlbumViewCell

- (void)setAlbum:(RCPlayerAlbum *)album{

    _album = album;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.titleLabel.text = album.title;
}
@end
