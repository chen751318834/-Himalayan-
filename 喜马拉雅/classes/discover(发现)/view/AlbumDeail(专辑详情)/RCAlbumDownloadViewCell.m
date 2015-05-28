//
//  RCAlbumDownloadViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDownloadViewCell.h"


@interface RCAlbumDownloadViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end
@implementation RCAlbumDownloadViewCell
+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCAlbumDownloadViewCell" owner:nil options:nil]lastObject];
}
- (void)setList:(RCTrackList *)list{
    _list = list; 
    self.titleLabel.text = list.title;
    self.sizeLabel.text  = [NSString stringWithFormat:@"%.2fMB", [list.downloadSize intValue]/1024.0/1024.0];
    self.selectedButton.selected = list.isCheck;
}

@end
