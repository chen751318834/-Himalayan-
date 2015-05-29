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
    [self setUpWithButton:self.playCountLabel count:[list.playsCounts intValue]
  title:nil];
}
- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{
        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [button setTitle:title forState:UIControlStateNormal];
    }

}
@end
