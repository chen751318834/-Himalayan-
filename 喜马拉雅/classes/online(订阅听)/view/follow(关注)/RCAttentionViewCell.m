//
//  RCAttentionViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAttentionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface RCAttentionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTiltlelabel;

@property (weak, nonatomic) IBOutlet UIImageView *smallIconView;
@property (weak, nonatomic) IBOutlet UILabel *smallTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallSubTiltlelabel;


@end
@implementation RCAttentionViewCell

+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCAttentionViewCell" owner:nil options:nil]lastObject];
}

- (void)setData:(RCAttentionFrData *)data{
    _data = data;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data.albumCover] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]];
        self.titleLabel.text = data.albumTitle;
        self.subTiltlelabel.text = data.trackTitle;

    [self.smallIconView sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.smallIconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    self.smallTitleLabel.text = data.nickname;
    self.smallSubTiltlelabel.text = data.personalSignature;
}
@end
