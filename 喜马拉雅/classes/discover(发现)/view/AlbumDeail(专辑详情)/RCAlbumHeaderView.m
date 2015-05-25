//
//  RCAlbumHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumHeaderView.h"
#import "CSStickyHeaderFlowLayoutAttributes.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface RCAlbumHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smallIconView;

@end
@implementation RCAlbumHeaderView


- (void)setAlbum:(RCOneAlbum *)album{
    _album = album;
    self.nickNameLabel.text = album.nickname;
    self.tilteLabel.text = album.title;
    self.subTitleLabel.text = album.intro;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.coverLarge] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
     [self.smallIconView sd_setImageWithURL:[NSURL URLWithString:album.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.smallIconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
     }];

}
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCAlbumHeaderView" owner:nil options:nil]lastObject];
}
- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {

    [UIView beginAnimations:@"" context:nil];

    if (layoutAttributes.progressiveness <= 0.58) {
        self.tilteLabel.alpha = 1;
    } else {
        self.tilteLabel.alpha = 0;
    }

      [UIView commitAnimations];
}
@end
