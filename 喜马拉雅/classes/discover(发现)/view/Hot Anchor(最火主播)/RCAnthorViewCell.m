//
//  RCAnthorViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAnthorViewCell.h"
#import "UIImageView+WebCache.h"
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
- (void)setAnthorList:(RCAnchorList *)anthorList{
    _anthorList = anthorList;
    NSArray * lists = anthorList.list;
    [self.titleButton setTitle:anthorList.title forState:UIControlStateNormal];

    RCOneAnchorList * list1 = lists[0];
    self.title1Label.text = list1.nickname;
    [self.iocn1View sd_setImageWithURL:[NSURL URLWithString:list1.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];


    RCOneAnchorList * list2 = lists[1];
    self.title2Label.text = list2.nickname;
    [self.iocn2View sd_setImageWithURL:[NSURL URLWithString:list2.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];


    RCOneAnchorList * list3 = lists[2];
    self.title3Label.text = list1.nickname;
    [self.iocn3View sd_setImageWithURL:[NSURL URLWithString:list3.smallLogo] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
}
@end
