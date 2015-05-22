//
//  RCSubjectViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSubjectViewCell.h"
#import "UIImageView+WebCache.h"
@interface RCSubjectViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation RCSubjectViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCSubjectViewCell" owner:nil options:nil] firstObject];

}
- (void)setList:(RCSubjectList *)list{
    _list = list;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverPathBig] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.titleLabel.text = list.title;

}

@end
