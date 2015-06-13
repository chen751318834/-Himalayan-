//
//  RCAllConditionTrackViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAllConditionTrackViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"

@interface RCAllConditionTrackViewCell ()
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountLabelWidth;
@end
@implementation RCAllConditionTrackViewCell

- (void)setDoc:(RCconditionOfAllTrackDoc *)doc{

    _doc = doc;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:doc.cover_path] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    if ([doc.user_source  isEqual: @1]) {
        self.soureLabel.text = @"原创";
    }else{
        self.soureLabel.text = @"采集";
    }
    self.titleLabel.text = doc.title;
    self.subTitleLabel.text = [NSString stringWithFormat:@"by %@",doc.nickname];

    [self.titleLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [doc.duration integerValue]/60,[doc.duration integerValue]%60] forState:UIControlStateNormal];

        [self setUpWithButton:self.playCountLabel count:[doc.count_play longLongValue] title:nil];

        [self setUpWithButton:self.saveCountLabel count:[doc.count_share longLongValue] title:nil];

        [self setUpWithButton:self.sayCountLabel count:[doc.count_comment longLongValue] title:nil];
        self.createTImeLabel.text = doc.createdTime;



}
- (void)setUpWithButton:(UIButton *)button count:(long long)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{

        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%lld",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

        [button setTitle:title forState:UIControlStateNormal];


    }

}
@end
