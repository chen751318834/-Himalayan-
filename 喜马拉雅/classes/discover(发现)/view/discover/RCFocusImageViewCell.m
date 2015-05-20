//
//  RCFocusImageViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCFocusImageViewCell.h"
#import "RCConst.h"
#import "UIImageView+WebCache.h"
@interface RCFocusImageViewCell ()
@property(nonatomic,weak) UIImageView *imageview;
@end
@implementation RCFocusImageViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        UIImageView * imageview =[[UIImageView alloc]init];
        [self addSubview:imageview];
        self.imageview = imageview;

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageview autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)setList:(RCList *)list{
    _list = list;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:list.pic] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
  

}
@end
