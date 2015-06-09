//
//  RCAlbumDeailViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDeailViewCell.h"
#import "NSDate+RC.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "RCDownloadTool.h"
@interface RCAlbumDeailViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTImeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *sayCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleLeghtLabel;
@property (weak, nonatomic) IBOutlet UILabel *soureLabel;
@end
@implementation RCAlbumDeailViewCell
- (void)setTrackList:(RCTrackList *)trackList{

    _trackList = trackList;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:trackList.albumImage] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    if ([trackList.userSource  isEqual: @1]) {
        self.soureLabel.text = @"原创";
    }else{
        self.soureLabel.text = @"采集";

    }

    self.titleLabel.text = trackList.title;
    self.subTitleLabel.text = [NSString stringWithFormat:@"by %@",trackList.nickname];
    [self.titleLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [trackList.duration integerValue]/60,[trackList.duration integerValue]%60] forState:UIControlStateNormal];
    [self setUpWithButton:self.playCountLabel count:[trackList.playtimes intValue] title:nil];
    [self setUpWithButton:self.saveCountLabel count:[trackList.likes intValue] title:nil];
    [self setUpWithButton:self.sayCountLabel count:[trackList.comments intValue] title:nil];
        self.downloadButton.selected = [RCDownloadTool isDownloadingAudio:trackList]?[RCDownloadTool isDownloadingAudio:trackList]:[RCDownloadTool isDownloadAudio:trackList];
    self.createTImeLabel.text = trackList.created_at;
}


- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{

        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

        //大于14000  -> 1.4万

        //大于10445  -> 1万
        [button setTitle:title forState:UIControlStateNormal];
        
        
    }
    
}

@end
