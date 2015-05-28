//
//  RCAlbumHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumHeaderView.h"
#import "UIImageView+EXtension.h"
#import "CSStickyHeaderFlowLayoutAttributes.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "UIImage+RC.h"
#import "RCTabBarViewController.h"
#import "RCOneAlbumViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCNavigationController.h"
#import "RCAlbumDownLoadViewController.h"
@interface RCAlbumHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smallIconView;
@property (weak, nonatomic) IBOutlet UIImageView *bgimageView;
@property (weak, nonatomic) IBOutlet UIView *tagContentView;
@property(nonatomic,strong) NSMutableArray  *buttons;
@end
@implementation RCAlbumHeaderView
-  (NSMutableArray *)buttons{
    if (!_buttons) {
         self.buttons = [NSMutableArray array];

    }
    return _buttons;
}

- (void)setAlbum:(RCOneAlbum *)album{
    _album = album;
    self.nickNameLabel.text = album.nickname;
    self.tilteLabel.text = album.title;
    self.subTitleLabel.text = album.intro;


    [self.bgimageView sd_setImageWithURL:[NSURL URLWithString:album.coverOrigin] placeholderImage:[UIImage imageNamed:@"bg_albumView_header"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.bgimageView setImageToBlur:image blurRadius:40 completionBlock:^(NSError *error) {

        }];
    }];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:album.coverLarge] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
     [self.smallIconView sd_setImageWithURL:[NSURL URLWithString:album.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.smallIconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
     }];

    NSMutableArray * tags = [NSMutableArray array];
    [album.tags enumerateStringsSeparatedByRegex:@"," usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [tags addObject:*capturedStrings];

    }];
    for (int i = 0; i<tags.count; i++) {
        NSString * tag  = tags[i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tagContentView addSubview:button];
        [button setBackgroundImage:[UIImage imageNamed:@"sound_act"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button  setFont:[UIFont systemFontOfSize:11]];
        [button setTitle:tag forState:UIControlStateNormal];
        [self.buttons addObject:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {


            RCTabBarViewController * tabBarVC =(RCTabBarViewController *)   [UIApplication sharedApplication].keyWindow.rootViewController;
            RCNavigationController * navVC = ( RCNavigationController *)tabBarVC.selectedViewController;
            RCOneAlbumViewController * albumVc = [[RCOneAlbumViewController alloc]init];
            albumVc.tag = button.currentTitle;
            [navVC pushViewController:albumVc animated:YES];

        }];

    }
}
- (void)layoutSubviews{

    [super layoutSubviews];

    CGFloat Y = 10;
    CGFloat H = 20;
    for (int i = 0; i<self.buttons.count; i++) {
        UIButton * button = self.buttons[i];
        CGFloat W  = 50;
        CGFloat X = i*(W +5);
        button.frame = CGRectMake(X, Y, W, H);
    }

}
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCAlbumHeaderView" owner:nil options:nil]lastObject];
}
- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {

    [UIView beginAnimations:@"" context:nil];
    if (layoutAttributes.progressiveness <= 0.30) {
        self.nickNameLabel.alpha = 0;
        self.iconView.alpha = 0;
        self.smallIconView.alpha = 0;
        self.subTitleLabel.alpha = 0;
        self.tilteLabel.alpha = 1;
        self.tagContentView.alpha = 0;
    }else{

        self.nickNameLabel.alpha = 1;
        self.iconView.alpha = 1;
        self.smallIconView.alpha = 1;
        self.subTitleLabel.alpha = 1;
        self.tagContentView.alpha = 1;
        self.tilteLabel.alpha = 0;
    }
      [UIView commitAnimations];
}

- (IBAction)download:(id)sender {
    RCTabBarViewController * tabBarVC =(RCTabBarViewController *)   [UIApplication sharedApplication].keyWindow.rootViewController;
    RCNavigationController * navVC = ( RCNavigationController *)tabBarVC.selectedViewController;
   RCAlbumDownLoadViewController * VC = [[RCAlbumDownLoadViewController alloc]init];
    VC.tracklist = self.tracklist;
    [navVC pushViewController:VC animated:YES];
}
- (IBAction)tuijainAlbum:(id)sender {
}

@end
