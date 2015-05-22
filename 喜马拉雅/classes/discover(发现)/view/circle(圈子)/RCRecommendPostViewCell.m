//
//  RCRecommendPostViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRecommendPostViewCell.h"
#import "UIImage+RC.h"
#import "NSDate+RC.h"
#import "RCRecommendPoster.h"
#import "UIImageView+WebCache.h"
@interface RCRecommendPostViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iamge1View;
@property (weak, nonatomic) IBOutlet UIImageView *iamge2View;
@property (weak, nonatomic) IBOutlet UIImageView *iamge3View;
@property (weak, nonatomic) IBOutlet UIButton *messageCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *numOfCommentsButton;

@end
@implementation RCRecommendPostViewCell
- (void)setPost:(RCRecommendedPost *)post{
    _post = post;
    self.timeLabel.text = post.created_at;
    self.titleLabel.text = post.title;
    self.contentLabel.text = post.content;
    RCRecommendPoster * poster = post.poster;
    self.userNameLabel.text = poster.nickname;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:poster.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];

        if (post.images.count ==1) {
            NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
            if (imageUrl1 != nil) {
                [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0?[UIImage imageNamed:@"find_albumcell_cover_bg"]:nil];
            }

        }

        if (post.images.count == 3) {
            NSString * imageUrl2 = post.images[2][0][@"imageUrl"];
            if (imageUrl2 != nil) {
                [self.iamge2View sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:imageUrl2.length >0?[UIImage imageNamed:@"find_albumcell_cover_bg"]:nil];

            }
        }

        if (post.images.count == 2) {
            NSString * imageUrl3 = post.images[1][0][@"imageUrl"];
            if (imageUrl3 !=  nil) {
                [self.iamge3View sd_setImageWithURL:[NSURL URLWithString:imageUrl3] placeholderImage:imageUrl3.length >0?[UIImage imageNamed:@"find_albumcell_cover_bg"]:nil];
            }
        }
    [self.numOfCommentsButton setTitle:[NSString stringWithFormat:@"%@",post.numOfComments] forState:UIControlStateNormal];


}
@end
