//
//  RCHotActivityViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotActivityViewCell.h"

#import "UIImageView+WebCache.h"
@interface RCHotActivityViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *isActivityButton;

@end
@implementation RCHotActivityViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCHotActivityViewCell" owner:nil options:nil] lastObject];
}
- (void)setActivity:(RCHotActivity *)activity{
    _activity = activity;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:activity.coverPathLarge] placeholderImage:[UIImage imageNamed:@"find_usercover"]];
    self.hotView.hidden = !activity.isHot;
    self.titleLabel.text = [NSString stringWithFormat:@"   %@",activity.title];
    if ([activity.activityStatus  isEqual: @2]) {
        self.isActivityButton.selected = YES;
    }else{
        self.isActivityButton.selected = NO;
    }
}
@end
