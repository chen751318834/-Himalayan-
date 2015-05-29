//
//  RCCollectViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCollectViewCell.h"
#import "RCAlbumTool.h"
#import "UIImageView+WebCache.h"
@interface RCCollectViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountLabelW;

@end
@implementation RCCollectViewCell

+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCCollectViewCell" owner:nil options:nil] lastObject];
}
- (void)setAlbum:(RCAlbum *)album{

    _album = album;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
    self.titlelabel.text = album.title;
    if (album.updatedAt) {
        self.updataTimelabel.text = [NSString stringWithFormat:@"最后更新 %@",album.updateTime];

    }else if ( album.lastUptrackAt){
        self.updataTimelabel.text = [NSString stringWithFormat:@"最后更新 %@",album.lastUptrackTime];

    }
    if (album.playsCounts) {
        [self setUpWithButton:self.playCountLabel count:[album.playsCounts intValue]
                        title:nil];
        self.playCountLabel.hidden = NO;
        self.playCountLabelW.constant = 60;
    }else{
        self.playCountLabel.hidden = YES;
        self.playCountLabelW.constant = 0;
    }
    if (album.tracksCounts) {
        [self setUpWithButton:self.audioCountLabel count:[album.tracksCounts intValue]
                        title:nil];
        self.audioCountLabel.hidden = NO;
    }else if (album.tracks){
        self.audioCountLabel.hidden = NO;
        [self setUpWithButton:self.audioCountLabel count:[album.tracks intValue]
                        title:nil];
    }else{
        self.audioCountLabel.hidden = YES;
    }
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
        [button setTitle:title forState:UIControlStateNormal];
    }
    
}

@end
