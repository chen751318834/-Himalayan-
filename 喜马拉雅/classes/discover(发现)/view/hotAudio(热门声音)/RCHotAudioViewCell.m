//
//  RCHotAudioViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioViewCell.h"
#import "NSDate+RC.h"
#import "UIImageView+WebCache.h"
#import "RCConst.h"
#import "UIImage+RC.h"
#import "RCDownloadTool.h"
@interface  RCHotAudioViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTImeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *sayCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleLeghtLabel;
@property (weak, nonatomic) IBOutlet UILabel *soureLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveCountLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sayCountLabelWidth;

@end
@implementation RCHotAudioViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCHotAudioViewCell" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib{

    [super awakeFromNib];
}

- (void)setAudio:(RCTrackList *)audio{
    _audio= audio;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:audio.coverSmall] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    if ([audio.userSource  isEqual: @1]) {
           self.soureLabel.text = @"原创";
    }else{
        self.soureLabel.text = @"采集";

    }

    self.titleLabel.text = audio.title;
        self.subTitleLabel.text = [NSString stringWithFormat:@"by %@",audio.nickname];

    [self.titleLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [audio.duration integerValue]/60,[audio.duration integerValue]%60] forState:UIControlStateNormal];    [self setUpWithButton:self.playCountLabel count:[audio.playsCounts?audio.playsCounts:audio.playTimes intValue] title:nil];
    if ([audio.sharesCounts intValue] != 0) {
        self.saveCountLabelWidth.constant =  60;
        self.saveCountLabel.hidden = NO;
        [self setUpWithButton:self.saveCountLabel count:[audio.sharesCounts intValue] title:nil];
    }else{
        self.saveCountLabel.hidden = YES;
        self.saveCountLabelWidth.constant =  0;
    }
    if ([audio.commentsCounts intValue] != 0) {
        self.sayCountLabelWidth.constant =  60;
        self.sayCountLabel.hidden = NO;
        [self setUpWithButton:self.sayCountLabel count:[audio.commentsCounts intValue] title:nil];
    }else{
        self.sayCountLabelWidth.constant = 0;
        self.sayCountLabel.hidden = YES;
    }
    if (audio.updatedAt) {
        self.createTImeLabel.text = audio.updatedTime;
    }else{
        self.createTImeLabel.text = audio.created_at;
    }
    self.downloadButton.selected = [RCDownloadTool isDownloadingAudio:audio]?[RCDownloadTool isDownloadingAudio:audio]:[RCDownloadTool isDownloadAudio:audio];
}
- (void)setSearchUserInfo:(RCSearchUserInfo *)searchUserInfo{
    _searchUserInfo = searchUserInfo;
    self.subTitleLabel.text = [NSString stringWithFormat:@"by %@",searchUserInfo.nickname];
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
