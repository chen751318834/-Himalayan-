//
//  RCBuildingOnwerViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBuildingOnwerViewCell.h"
#import "UIImage+RC.h"
#import "UIImageView+WebCache.h"

@interface RCBuildingOnwerViewCell ()
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView3H;

@end
@implementation RCBuildingOnwerViewCell
- (void)setPost:(RCRecommendedPost *)post{
    _post = post;
    self.timeLabel.text = post.created_at;
    self.titleLabel.text = post.title;
    RCRecommendPoster * poster = post.poster;
    self.userNameLabel.text = poster.nickname;
    self.contentLabel.text = post.content;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:poster.smallLogo] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];

    [self.numOfCommentsButton setTitle:[NSString stringWithFormat:@"%@",post.numOfComments] forState:UIControlStateNormal];



    UIImage * placeHolderImage = [UIImage imageNamed:@"find_usercover"];
    if (post.images.count == 0) {
        self.iamge1View.hidden = YES;
        self.iamge2View.hidden = YES;
        self.iamge3View.hidden = YES;
        self.imageView1H.constant = 0;
        self.imageView2H.constant = 0;
        self.imageView3H.constant = 0;

    } else if (post.images.count ==1) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = YES;
        self.iamge3View.hidden = YES;
        CGFloat width1 = [post.images[0][0][@"width"] floatValue];
        CGFloat height1 =[ post.images[0][0][@"height"] floatValue];
        self.imageView1H.constant = (self.bounds.size.width- 48) * height1/width1;
        self.imageView2H.constant = 0;
        self.imageView3H.constant = 0;

        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];

    }else if (post.images.count == 2) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = NO;
        self.iamge3View.hidden = YES;
        CGFloat width1 = [post.images[0][0][@"width"] floatValue];
        CGFloat height1 =[ post.images[0][0][@"height"] floatValue];
        self.imageView1H.constant = (self.bounds.size.width- 48) * height1/width1;
        CGFloat width2 = [post.images[1][0][@"width"] floatValue];
        CGFloat height2 =[ post.images[1][0][@"height"] floatValue];
        self.imageView2H.constant = (self.bounds.size.width- 48) * height2/width2;
        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        self.imageView3H.constant = 0;

        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
        NSString * imageUrl2 = post.images[1][0][@"imageUrl"];
        [self.iamge2View sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:imageUrl2.length >0  ? placeHolderImage:nil];
    } else if (post.images.count == 3) {
        self.iamge1View.hidden = NO;
        self.iamge2View.hidden = NO;
        self.iamge3View.hidden = NO;
        CGFloat width1 = [post.images[0][0][@"width"] floatValue];
        CGFloat height1 =[ post.images[0][0][@"height"] floatValue];
        CGFloat width2 = [post.images[1][0][@"width"] floatValue];
        CGFloat height2 =[ post.images[1][0][@"height"] floatValue];
        CGFloat width3 = [post.images[2][0][@"width"] floatValue];
        CGFloat height3 =[ post.images[2][0][@"height"] floatValue];
        self.imageView1H.constant = (self.bounds.size.width- 48) * height1/width1;
        self.imageView2H.constant = (self.bounds.size.width- 48) * height2/width2;
        self.imageView3H.constant = (self.bounds.size.width- 48) * height3/width3;

        NSString * imageUrl1 = post.images[0][0][@"imageUrl"];
        [self.iamge1View sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:imageUrl1.length >0  ? placeHolderImage:nil];
        NSString * imageUrl2 = post.images[1][0][@"imageUrl"];
        [self.iamge2View sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:imageUrl2.length >0  ? placeHolderImage:nil];
        NSString * imageUrl3 = post.images[2][0][@"imageUrl"];
        [self.iamge3View sd_setImageWithURL:[NSURL URLWithString:imageUrl3] placeholderImage:imageUrl3.length >0  ? placeHolderImage:nil];
    }
    

}


@end
