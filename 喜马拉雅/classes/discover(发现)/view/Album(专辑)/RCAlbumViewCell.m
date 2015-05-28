//
//  RCAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumViewCell.h"
#import "UIImageView+WebCache.h"

@interface RCAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;

@end
@implementation RCAlbumViewCell
+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCAlbumViewCell" owner:nil options:nil] lastObject];
}
- (void)setAlbum:(RCAlbum *)album{

    _album = album;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
    self.titlelabel.text = album.title;
    self.updataTimelabel.text = album.updateTime;
    [self setUpWithButton:self.playCountLabel count:[album.playsCounts intValue]
   title:@"0"];
    [self setUpWithButton:self.audioCountLabel count:[album.tracksCounts intValue]
 title:@"0"];
    self.saveButton.selected = album.isCollect;


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
