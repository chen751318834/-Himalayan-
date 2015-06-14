//
//  RCUserInfoViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCUserInfoViewCell.h"

#import "UIImageView+WebCache.h"

@interface RCUserInfoViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *rzLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;

@end
@implementation RCUserInfoViewCell

- (void)setUserInfo:(RCSearchUserInfo *)userInfo{
    _userInfo = userInfo;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userInfo.mobileLargeLogo] placeholderImage:nil];
    self.namelabel.text = userInfo.nickname;
    self.rzLabel.text = userInfo.personDescribe;
    self.desclabel.text = userInfo.personalSignature;
}

@end
