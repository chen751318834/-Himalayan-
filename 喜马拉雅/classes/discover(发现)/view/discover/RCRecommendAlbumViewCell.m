//
//  RCRecommendAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCRecommendAlbumViewCell.h"
#import "UIImageView+WebCache.h"

@interface RCRecommendAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;

@end
@implementation RCRecommendAlbumViewCell
- (void)awakeFromNib{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
- (void)setList:(RCList *)list{
    _list = list;
    [self.icoView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"findsubject_large_bg"]];
    self.titleLabel.text = list.title;
    [self.playCountLabel setTitle:[NSString stringWithFormat:@"%@",list.playsCounts] forState:UIControlStateNormal];
}
@end
