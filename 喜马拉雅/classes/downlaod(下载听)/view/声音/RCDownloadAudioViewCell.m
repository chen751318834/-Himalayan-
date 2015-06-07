//
//  RCDownloadAudioViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAudioViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface RCDownloadAudioViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *sourelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeLeghtLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *sizelabel;

@end
@implementation RCDownloadAudioViewCell

- (void)setList:(RCTrackList *)list{
    _list = list;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];

    self.sourelabel.text = [NSString stringWithFormat:@"by %@",list.nickname];
    self.titlelabel.text = list.title;
    [self.timeLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [list.duration integerValue]/60,[list.duration  integerValue]%60] forState:UIControlStateNormal];
    [self setUpWithButton:self.playCountLabel count:[list.playsCounts intValue] title:nil];
    [self setUpWithButton:self.saveCountLabel count:[list.sharesCounts intValue] title:nil];
    self.sizelabel.text = [NSString stringWithFormat:@"%.2fMB",[list.downloadSize intValue]/1024.0/1024.0];

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
