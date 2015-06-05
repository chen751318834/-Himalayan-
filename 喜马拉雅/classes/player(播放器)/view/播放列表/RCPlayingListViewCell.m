//
//  RCPlayListViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayingListViewCell.h"


@interface RCPlayingListViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playingImageView;

@end
@implementation RCPlayingListViewCell
+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCPlayingListViewCell" owner:nil options:nil]lastObject];
}
- (void)setList:(RCPlaylist *)list{
    _list = list;
    self.titleLabel.text = list.title;
    if (list.isPlaying) {
        self.titleLabel.textColor = [UIColor redColor];
        self.playingImageView.hidden = NO;
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.playingImageView.hidden = YES;
    }
    self.downloadButton.selected = list.isDownloaded;
}
@end
