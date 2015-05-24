
//
//  RCCommentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCommentViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCRecommendPoster.h"
#import "UIImage+RC.h"
#import "UIView+FDCollapsibleConstraints.h"

@interface RCCommentViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *buildingFollorlabel;


@property (weak, nonatomic) IBOutlet UIImageView *reweetedIconView;
@property (weak, nonatomic) IBOutlet UILabel *reweetedUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reweetedTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *reweetedContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *reweetedBuildingFollorlabel;
@property (weak, nonatomic) IBOutlet UIView *reweetedContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCon;

@end
@implementation RCCommentViewCell

- (void)setOneComment:(RCOneComment *)oneComment{
    _oneComment = oneComment;
    RCRecommendPoster * poster = oneComment.poster;

     [self.iconView sd_setImageWithURL:[NSURL URLWithString:poster.smallLogo] placeholderImage:[UIImage imageNamed:@"find_usercover"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
     }];
    self.userNameLabel.text = poster.nickname;
    self.timelabel.text = oneComment.created_at;
    self.buildingFollorlabel.text = [NSString stringWithFormat:@"%@楼",oneComment.numOfFloor ];
    self.contentLabel.text = oneComment.content;


        self.reweetedUserNameLabel.text = oneComment.parentComment.poster.nickname;
        self.reweetedTimelabel.text = oneComment.parentComment.created_at;
        self.reweetedBuildingFollorlabel.text = oneComment.parentComment.numOfFloor?[NSString stringWithFormat:@"%@楼",oneComment.parentComment.numOfFloor ]:@"";

        self.reweetedContentLabel.text = oneComment.parentComment.content;
        [self.reweetedIconView sd_setImageWithURL:[NSURL URLWithString:oneComment.parentComment.poster.smallLogo] placeholderImage:[UIImage imageNamed:@"find_usercover"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.reweetedIconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
        }];
        if (oneComment.parentComment != nil) {
            self.reweetedContentView.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.250];
            self.topCon.constant = 0;

    }else{
        self.reweetedContentView.backgroundColor = [UIColor whiteColor];
        self.topCon.constant = -30;


    }



}



@end
