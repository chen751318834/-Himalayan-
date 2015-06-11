//
//  RCUserInfoHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserInfoHeaderView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "UIImageView+EXtension.h"
#import "UIView+JHChainableAnimations.h"
#import "JHKeyframeAnimation.h"
@interface RCUserInfoHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *largeIconView;
@property (weak, nonatomic) IBOutlet UIImageView *avataIconVIew;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIButton *carePersonButton;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewTopCon;
@property(nonatomic,assign,getter=isOpen) BOOL open;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end
@implementation RCUserInfoHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCUserInfoHeaderView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{

    [super awakeFromNib];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLargeiconView)];
    [self.largeIconView addGestureRecognizer:tap];
}
- (void)tapLargeiconView{
    if (self.isOpen) {
        self.contentView.moveY(60).animate(0.5);
        self.arrow.rotate(180).animate(0.5);
        self.avataIconVIew.makeOpacity(1).rotate(180).animate(0.5);
        self.largeIconView.userInteractionEnabled = NO;
        self.contentView.animationCompletion = JHAnimationCompletion(){
            self.desclabel.text = self.userInfo.personDescribe;
            self.largeIconView.userInteractionEnabled = YES;
        };
    }else{
        self.largeIconView.userInteractionEnabled = NO;
        self.contentView.moveY(-60).animate(0.5);
        self.arrow.rotate(180).animate(0.5);
        self.avataIconVIew.makeOpacity(0).rotate(180).animate(0.5);
        self.contentView.animationCompletion = JHAnimationCompletion(){
            self.desclabel.text = self.userInfo.personalSignature;
            self.largeIconView.userInteractionEnabled = YES;

        };
    }
    self.open = !self.isOpen;
}
- (void)setUserInfo:(RCSearchUserInfo *)userInfo{
    _userInfo = userInfo;
    [self.largeIconView sd_setImageWithURL:[NSURL URLWithString:userInfo.backgroundLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.largeIconView setImageToBlur:image blurRadius:20 completionBlock:nil];
    }];
    [self.avataIconVIew sd_setImageWithURL:[NSURL URLWithString:userInfo.mobileSmallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avataIconVIew.image = [UIImage circleImage:image borderWidth:3 borderColor:[UIColor orangeColor]];
    }];
    self.namelabel.text = userInfo.nickname;
    self.desclabel.text = userInfo.personDescribe;
    [self setUpButton:self.fansButton count:[userInfo.followers intValue]   title:[NSString stringWithFormat:@"%@\n粉丝",userInfo.followers]];
    [self setUpButton:self.zanButton count:[userInfo.tracks intValue]   title:[NSString stringWithFormat:@"%@\n赞过的",userInfo.tracks]];
    [self setUpButton:self.carePersonButton count:[userInfo.favorites intValue]   title:[NSString stringWithFormat:@"%@\n关注的人",userInfo.favorites]];

  }
- (void)setUpButton:(UIButton *)button  count:(int )count  title:(NSString *)title{

    button.titleLabel.numberOfLines = 0;
    NSMutableDictionary * attr = [NSMutableDictionary dictionary];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:title attributes:attr];
    NSRange range = [title rangeOfString:[NSString stringWithFormat:@"%d",count]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range
     ];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range
     ];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(range.length+1 ,   title.length - range.length - 1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor]range:NSMakeRange(range.length+1 ,   title.length - range.length - 1)];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;

    [button setAttributedTitle:attrString forState:UIControlStateNormal];


}
@end
