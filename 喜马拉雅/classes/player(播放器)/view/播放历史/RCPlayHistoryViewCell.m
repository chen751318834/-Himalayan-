//
//  RCPlayHistoryViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayHistoryViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCplayerUserInfo.h"
@interface RCPlayHistoryViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;

@end
@implementation RCPlayHistoryViewCell
+ (instancetype)cell {
    return [[[NSBundle mainBundle]loadNibNamed:@"RCPlayHistoryViewCell" owner:nil options:nil]lastObject];
}
- (void)setInfo:(RCPlayerInfo *)info{
    _info = info;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:info.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.titlelabel.text = info.albumTitle;
    self.authorLabel.text = [NSString stringWithFormat:@"by %@",info.userInfo.nickname];
    self.desclabel.text = [NSString stringWithFormat:@"上传播放 %@",info.title];
}
@end
