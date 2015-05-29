//
//  RCAboutAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAboutAlbumViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCAlbumTool.h"
@interface RCAboutAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;
@end
@implementation RCAboutAlbumViewCell

+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCAboutAlbumViewCell" owner:nil options:nil] lastObject];
}
- (void)setAlbum:(RCAlbum *)album{
    _album = album;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.coverSmall] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
    self.titlelabel.text = album.title;
    [self setUpWithButton:self.audioCountLabel count:[album.tracks intValue]
                    title:@"0"];
    self.updataTimelabel.text = album.updateTime;
    self.saveButton.selected = [RCAlbumTool isCollectAlbum:album];
    
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
