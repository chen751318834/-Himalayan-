//
//  RCAnthorViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAnthorViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCmoreHotAnthorViewController.h"
#import "RCNavigationController.h"
#import "RCUserViewController.h"
#import "RCOneAnchorList.h"
@interface RCAnthorViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIImageView *iocn1View;
@property (weak, nonatomic) IBOutlet UILabel *title1Label;
@property (weak, nonatomic) IBOutlet UIButton *follow1Button;

@property (weak, nonatomic) IBOutlet UIImageView *iocn2View;
@property (weak, nonatomic) IBOutlet UILabel *title2Label;
@property (weak, nonatomic) IBOutlet UIButton *follow2Button;

@property (weak, nonatomic) IBOutlet UIImageView *iocn3View;
@property (weak, nonatomic) IBOutlet UILabel *title3Label;
@property (weak, nonatomic) IBOutlet UIButton *follow3Button;
@end
@implementation RCAnthorViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCAnthorViewCell" owner:nil options:nil]firstObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * icon1Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcon1View)];
        UITapGestureRecognizer * icon2Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcon2View)];
        UITapGestureRecognizer * icon3Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcon3View)];
    [self.iocn1View addGestureRecognizer:icon1Tap];
    [self.iocn2View addGestureRecognizer:icon2Tap];
    [self.iocn3View addGestureRecognizer:icon3Tap];
}
- (void)tapIcon1View{
    NSArray * lists = self.anthorList.list;
    RCOneAnchorList * list1 = lists[0];
    RCUserViewController * userVC = [[RCUserViewController alloc]init];
    userVC.ID = list1.uid;
    [[RCNavigationController navigationController] pushViewController:userVC animated:YES];
}
- (void)tapIcon2View{
    NSArray * lists = self.anthorList.list;
    RCOneAnchorList * list1 = lists[1];
    RCUserViewController * userVC = [[RCUserViewController alloc]init];
    userVC.ID = list1.uid;
    [[RCNavigationController navigationController] pushViewController:userVC animated:YES];
}
- (void)tapIcon3View{
    NSArray * lists = self.anthorList.list;
    RCOneAnchorList * list1 = lists[2];
    RCUserViewController * userVC = [[RCUserViewController alloc]init];
    userVC.ID = list1.uid;
    [[RCNavigationController navigationController] pushViewController:userVC animated:YES];
}
- (void)setAnthorList:(RCAnchorList *)anthorList{
    _anthorList = anthorList;
    NSArray * lists = anthorList.list;

    RCOneAnchorList * list1 = lists[0];
    [self.titleButton setTitle:anthorList.title forState:UIControlStateNormal];
    self.title1Label.text = list1.nickname;
    [self.iocn1View sd_setImageWithURL:[NSURL URLWithString:list1.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];


    RCOneAnchorList * list2 = lists[1];
    self.title2Label.text = list2.nickname;
    [self.iocn2View sd_setImageWithURL:[NSURL URLWithString:list2.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];


    RCOneAnchorList * list3 = lists[2];
    self.title3Label.text = list1.nickname;
    [self.iocn3View sd_setImageWithURL:[NSURL URLWithString:list3.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
}
- (IBAction)titleButtonDidClicked:(UIButton *)sender {
    RCmoreHotAnthorViewController * vc = [[RCmoreHotAnthorViewController alloc]init];
    [[RCNavigationController navigationController] pushViewController:vc animated:YES];
}
@end
