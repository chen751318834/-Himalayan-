//
//  RCHotAudioViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface  RCHotAudioViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTImeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *sayCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleLeghtLabel;

@end
@implementation RCHotAudioViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCHotAudioViewCell" owner:nil options:nil] lastObject];
}

- (void)setAudio:(RCOnneHotAudio *)audio{
    _audio= audio;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:audio.coverSmall] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    /**
     *   "id": 283384,
     "uid": 1372242,
     "title": "催眠音乐 仙境催眠曲",
     "nickname": "催眠音乐",
     "duration": 302.21,
     "playsCounts": 5006299,
     "commentsCounts": 5616,
     "sharesCounts": 2143,
     "favoritesCounts": 28533,
     "userSource": 2,
     "createdAt": 1366090550000
     */

    self.titleLabel.text = audio.title;
    self.subTitleLabel.text = [NSString stringWithFormat:@"by %@",audio.nickname];
    [self.playCountLabel setTitle:[NSString stringWithFormat:@"%@",audio.playsCounts] forState:UIControlStateNormal];
    [self.saveCountLabel setTitle:[NSString stringWithFormat:@"%@",audio.sharesCounts] forState:UIControlStateNormal];
    [self.sayCountLabel setTitle:[NSString stringWithFormat:@"%@",audio.commentsCounts] forState:UIControlStateNormal];
    [self.titleLeghtLabel setTitle:[NSString stringWithFormat:@"%@",audio.duration] forState:UIControlStateNormal];

}
- (IBAction)download:(id)sender {
}

@end
