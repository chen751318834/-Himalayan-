//
//  RCRecommendPostViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRecommendPostViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagevIewH;

@end
@implementation RCRecommendPostViewCell
- (void)awakeFromNib{
}
- (void)setPost:(RCRecommendedPost *)post{
    _post = post;
    UIImage * placeHolderImage = [UIImage imageNamed:@"find_albumcell_cover_bg"];
    if (post.images.count == 0) {
        self.iamge1View.hidden = YES;
        self.iamge2View.hidden = YES;
        self.iamge3View.hidden = YES;
        self.imagevIewH.constant = 0;

    } else if (post.images.count ==1) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = YES;
        self.iamge3View.hidden = YES;
        self.imagevIewH.constant = 100;

        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];

    }else if (post.images.count == 2) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = NO;
        self.iamge3View.hidden = YES;
        self.imagevIewH.constant = 100;
        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
        NSString * imageUrl2 = post.images[1][0][@"imageUrl"];
        [self.iamge2View sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
    } else if (post.images.count == 3) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = NO;
        self.iamge3View.hidden = NO;
        self.imagevIewH.constant = 100;
        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
        NSString * imageUrl2 = post.images[1][0][@"imageUrl"];
        [self.iamge2View sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
        NSString * imageUrl3 = post.images[2][0][@"imageUrl"];
        [self.iamge3View sd_setImageWithURL:[NSURL URLWithString:imageUrl3] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
    }
    self.timeLabel.text = post.created_at;
    self.titleLabel.text = post.title;
        self.contentLabel.text = post.content;


    RCRecommendPoster * poster = post.poster;
    self.userNameLabel.text = poster.nickname;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:poster.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];



    [self.numOfCommentsButton setTitle:[NSString stringWithFormat:@"%@",post.numOfComments] forState:UIControlStateNormal];


}
@end
