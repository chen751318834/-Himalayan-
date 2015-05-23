//
//  RCCicleDeailHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCicleDeailHeaderView.h"
#import "UIImage+RC.h"
#import "UIImageView+WebCache.h"
@interface RCCicleDeailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *zoneCountLabel;
@end
@implementation RCCicleDeailHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCCicleDeailHeaderView" owner:nil options:nil]lastObject];
}

- (void)setZone:(RCZonePostHeadData *)zone{
    _zone = zone;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:zone.imageUrl] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
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
