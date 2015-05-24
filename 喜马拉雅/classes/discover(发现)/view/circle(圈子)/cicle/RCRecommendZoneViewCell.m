//
//  RCRecommendZoneViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRecommendZoneViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIImageView+WebCache.h"
@interface RCRecommendZoneViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *zoneCountLabel;

@end
@implementation RCRecommendZoneViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.fd_isTemplateLayoutCell = YES;
}
- (void)setZone:(RCRecommendedZones *)zone{
    _zone = zone;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:zone.imageUrl] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"]];
    self.titleLabel.text =zone.displayName;
    self.zoneCountLabel.text = [NSString stringWithFormat:@"成员%@  帖子%@",[self textWithCount:zone.numOfMembers],[self textWithCount:zone.numOfPosts]];
    self.subTitlelabel.text =zone.desc;
}
- (NSString *)textWithCount:(NSNumber *)count{
    NSString * text = nil;
    if ([count intValue] ==0) {
        self.zoneCountLabel.hidden = YES;
    }else{
        self.zoneCountLabel.hidden = NO;

        //小于1000
        if ([count intValue]  <10000) {  //小于1000
            text = [NSString stringWithFormat:@"%d",[count intValue]];
        }else if([count intValue] >10000){    //大于一万
            text = [NSString stringWithFormat:@"%.1f万",([count intValue])/10000.0];
            text = [text stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

    }
    return text;

}
@end
