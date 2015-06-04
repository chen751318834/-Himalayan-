//
//  RCPlayerCommentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerCommentViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCCommnetTextView.h"
#include "UIImage+RC.h"
@interface RCPlayerCommentViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet RCCommnetTextView *contentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewH;

@end
@implementation RCPlayerCommentViewCell

- (void)setList:(RCPlayerCommnetList *)list{
    _list  = list;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.smallHeader] placeholderImage:[UIImage imageNamed:@"sound_albumcover"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    self.userNameLabel.text = list.nickname;
    self.timeLabel.text = list.createTime;
//    self.floorLabel.text  = list.parentId;
    self.contentTextView.text = list.content;
    self.contentTextViewH.constant = [list.content boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height+5;
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼",list.follor];
}

@end
