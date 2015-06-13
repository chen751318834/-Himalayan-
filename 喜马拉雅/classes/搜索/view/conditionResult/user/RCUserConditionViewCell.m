//
//  RCUserConditionViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserConditionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
#import "UIView+FDCollapsibleConstraints.h"
@interface RCUserConditionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclabelHight;
@end
@implementation RCUserConditionViewCell

- (void)setDoc:(RCConditionResponseDoc *)doc{
    _doc = doc;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:doc.smallPic] placeholderImage:[UIImage imageNamed:@"sound_albumcover_large"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
    }];
    self.namelabel.text = doc.nickname;
    [self setUpWithlabel:self.audioCountLabel count:[doc.tracks_counts intValue] title:@"声音"];
    [self setUpWithlabel:self.fansCountLabel count: [doc.followings_counts intValue] title:@"粉丝"];
    self.desclabel.text = doc.intro;

}
- (void)setUpWithlabel:(UILabel *)label count:(int)count title:(NSString *)title {
    if (count ==0) {
        label.text = [NSString stringWithFormat:@"%@ 0",title];
    }else{

        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@" %@ %d",title,count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@" %@ %.1f万" ,title,count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

        //大于14000  -> 1.4万

        //大于10445  -> 1万
        label.text = title;

    }

}
- (IBAction)add:(id)sender {
}

@end
