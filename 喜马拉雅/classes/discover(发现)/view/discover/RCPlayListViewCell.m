//
//  RCPlayListViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCPlayListViewCell.h"


@interface RCPlayListViewCell ()
@property(nonatomic,weak) UIButton   *button;

@end
@implementation RCPlayListViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton  * button = [[UIButton alloc]init];
        [self addSubview:button];
        button.contentMode = UIViewContentModeCenter;
        button.userInteractionEnabled = NO;
        self.button = button;

    }
    return self;
}
- (void)setCaterory:(RCCatrgory *)caterory{
    _caterory = caterory;
    [self.button setImage:[UIImage imageNamed:caterory.itemIcon] forState:UIControlStateNormal];
}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.button.frame = self.bounds;
}

@end
