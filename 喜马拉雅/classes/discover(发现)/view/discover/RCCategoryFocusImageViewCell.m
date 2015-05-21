//
//  RCCategoryFocusImageViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCategoryFocusImageViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+AutoLayout.h"
@interface RCCategoryFocusImageViewCell ()
@property(nonatomic,weak) UIImageView *imageview;

@end
@implementation RCCategoryFocusImageViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor redColor];

        UIImageView * imageview =[[UIImageView alloc]init];
        imageview.userInteractionEnabled = YES;
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
