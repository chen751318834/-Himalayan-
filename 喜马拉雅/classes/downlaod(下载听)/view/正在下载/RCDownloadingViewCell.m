//
//  RCDownloadingViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadingViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCAlbum.h"
@interface RCDownloadingViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *sourelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *sayCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeLeghtLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadStateButton;



@end
@implementation RCDownloadingViewCell
+ (instancetype)cell{
    // Initialization code
//    _downloadedData = nil;
//    _downloadURL = url;
//    _download = [[SGdownloader alloc] initWithURL:url timeout:60];


    return [[[NSBundle mainBundle]loadNibNamed:@"RCDownloadingViewCell" owner:nil options:nil]lastObject];
}
- (void)setList:(RCTrackList *)list{
    _list = list;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if ([list.userSource  isEqual: @1]) {
        self.timelabel.text = [NSString stringWithFormat:@"%@ 原创",list.created_at];

    }else{
        self.timelabel.text = [NSString stringWithFormat:@"%@ 采集",list.created_at];

    }
    self.sourelabel.text = list.albumTitle;
    self.titlelabel.text = list.title;
    [self.timeLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [list.duration integerValue]/60,[list.duration  integerValue]%60] forState:UIControlStateNormal];
    [self setUpWithButton:self.playCountLabel count:[list.playsCounts intValue] title:nil];
    [self setUpWithButton:self.saveCountLabel count:[list.sharesCounts intValue] title:nil];
    [self setUpWithButton:self.sayCountLabel count:[list.commentsCounts intValue] title:nil];
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
