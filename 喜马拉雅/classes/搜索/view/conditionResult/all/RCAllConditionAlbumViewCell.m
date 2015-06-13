//
//  RCAllConditiondocViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAllConditionAlbumViewCell.h"
#import "UIImageView+WebCache.h"
@interface RCAllConditionAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountLabelW;
@end
@implementation RCAllConditionAlbumViewCell

- (void)setDoc:(RCconditionOfAllAlbumDoc *)doc{
    _doc= doc;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:doc.cover_path] placeholderImage:[UIImage imageNamed:@"sound_doccover"]];
    self.titlelabel.text = doc.title;
        self.updataTimelabel.text = [NSString stringWithFormat:@"最后更新 %@",doc.createdTime];
        [self setUpWithButton:self.playCountLabel count:[doc.play intValue]
                        title:nil];

        [self setUpWithButton:self.audioCountLabel count:[doc.tracks intValue]
                        title:nil];

}
- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{
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
