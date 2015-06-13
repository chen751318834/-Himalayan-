//
//  RCdocConditionViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumConditionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"

@interface RCAlbumConditionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountLabelW;

@end
@implementation RCAlbumConditionViewCell
- (void)setDoc:(RCConditionResponseDoc *)doc{
    _doc = doc;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:doc.cover_path] placeholderImage:[UIImage imageNamed:@"sound_doccover"]];
    self.titlelabel.text = doc.title;

    self.updataTimelabel.text = [NSString stringWithFormat:@"最后更新 %@",doc.createdTime];
        [self setUpWithButton:self.audioCountLabel count:[doc.play intValue]
                        title:nil];
    [self setUpWithButton:self.playCountLabel count:[doc.play intValue] title:nil];
    [self setUpWithButton:self.audioCountLabel count:[doc.tracks intValue] title:nil];

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
