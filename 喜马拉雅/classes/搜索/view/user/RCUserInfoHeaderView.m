//
//  RCUserInfoHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserInfoHeaderView.h"
#import "RCNavigationController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "RCUserDeailViewController.h"
#import "UIImageView+EXtension.h"
#import "RCUserInfoViewController.h"
#import "UIView+JHChainableAnimations.h"
#import "RCUserZanedViewController.h"
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
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
@implementation RCUserInfoHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCUserInfoHeaderView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * iconTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSmallIconView)];
    [self.avataIconVIew addGestureRecognizer:iconTap];

    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLargeiconView)];
    [self.largeIconView addGestureRecognizer:tap];
}
- (void)tapSmallIconView{
    RCUserInfoViewController * userInfoVC = [[RCUserInfoViewController alloc]init];
    RCNavigationController * nav = [[RCNavigationController alloc]initWithRootViewController:userInfoVC];
    userInfoVC.userInfo = self.userInfo;
    [[RCNavigationController navigationController] presentViewController:nav animated:YES completion:nil];
//    self.largeIconView.userInteractionEnabled = YES;

}
- (void)tapLargeiconView{
    if (self.isOpen) {
        self.arrow.rotate(180).animate(0.5);
        self.avataIconVIew.rotate(180).makeOpacity(1).animate(0.5);
        self.largeIconView.userInteractionEnabled = NO;
        self.contentView.moveY(60).animate(0.5);
        self.desclabel.text = self.userInfo.personDescribe;
        self.contentView.animationCompletion = JHAnimationCompletion(){
        self.largeIconView.userInteractionEnabled = YES;
        };
    }else{
        self.arrow.rotate(180).animate(0.5);
        self.avataIconVIew.rotate(180).makeOpacity(0).animate(0.5);
        self.largeIconView.userInteractionEnabled = NO;
        self.contentView.moveY(-60).animate(0.5);
        self.desclabel.text = self.userInfo.personalSignature;
        self.contentView.animationCompletion = JHAnimationCompletion(){
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
    [self setUpButton:self.carePersonButton count:[userInfo.followings intValue]   title:[NSString stringWithFormat:@"%@\n关注的人",userInfo.followings]];

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
- (IBAction)openCarePersonVC:(id)sender {
    RCUserDeailViewController * vc = [[RCUserDeailViewController alloc]init];
    vc.fansVC = NO;
    vc.ID = self.userInfo.uid;
    [[RCNavigationController navigationController] pushViewController:vc animated:YES];
}
- (IBAction)openFansVC:(id)sender {
    RCUserDeailViewController * vc = [[RCUserDeailViewController alloc]init];
    vc.ID = self.userInfo.uid;
    vc.fansVC = YES;
    [[RCNavigationController navigationController] pushViewController:vc animated:YES];
}

- (IBAction)openZanedVC:(id)sender {
    RCUserZanedViewController * vc = [[RCUserZanedViewController alloc]init];
    vc.ID = self.userInfo.uid;
    vc.title = @"赞过的";
    [[RCNavigationController navigationController] pushViewController:vc animated:YES];
}
- (void)shareWithTarget:(id)target action:(SEL)action{

    [self.shareButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)share:(id)sender {

}
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == self) {
//        return nil;
//    }
//    return view;
//}
@end
