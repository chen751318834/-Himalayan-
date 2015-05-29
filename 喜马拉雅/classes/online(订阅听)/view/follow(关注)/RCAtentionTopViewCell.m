//
//  RCAtentionTopViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAtentionTopViewCell.h"
#import "UIImageView+WebCache.h"

@interface RCAtentionTopViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTiltlelabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopCon;
@property (weak, nonatomic) IBOutlet UIButton *bageButton;

@end
@implementation RCAtentionTopViewCell

+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCAtentionTopViewCell" owner:nil options:nil]lastObject];
}
- (void)setData:(RCAttentionOneData *)data{
    _data = data;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data.albumCover] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
    self.timeLabel.text = data.updateTime;
    if (data.albumTitle) {
        self.titleLabel.text = data.albumTitle;
        self.titleLabelTopCon.constant = 0;
    }else{
        self.titleLabel.text = @"新鲜事";
        self.titleLabelTopCon.constant = -20;

    }
    if (data.trackTitle) {
        self.subTiltlelabel.text = data.trackTitle;
        self.subTiltlelabel.hidden = NO;

    }else{
        self.subTiltlelabel.hidden = YES;

    }
    if (data.nickname) {
        self.userNameLabel.hidden = NO;
        self.userNameLabel.text = [NSString stringWithFormat:@"by %@",data.nickname];

    }else{
        self.userNameLabel.hidden = YES;
    }
    if ([data.unreadNum intValue] > 0) {
        self.bageButton.hidden = NO;
        [self.bageButton setTitle:[NSString stringWithFormat:@"%@",data.unreadNum] forState:UIControlStateNormal];

    }else{
        self.bageButton.hidden = YES;
    }
}
@end
