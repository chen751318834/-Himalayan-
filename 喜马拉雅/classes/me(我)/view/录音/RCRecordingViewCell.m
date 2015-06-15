//
//  RCRecordingViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRecordingViewCell.h"
#import "UIView+AutoLayout.h"

@interface RCRecordingViewCell ()
@property(nonatomic,weak) UIButton   *button;

@end
@implementation RCRecordingViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.userInteractionEnabled= NO;
        [button setBackgroundImage:[UIImage imageNamed:@"record_bgMusic_n"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"record_bgMusic_local"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.contentMode = UIViewContentModeCenter;
        [self addSubview:button];
        self.button = button;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)setRecord:(RCRecord *)record{
    _record = record;
    if (record.text.length == 0) {
        [self.button setTitle:record.text forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"record_bgAdd_n"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"record_bgAdd_n"] forState:UIControlStateSelected];
    }else{
        [self.button setTitle:record.text forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"record_bgMusic_n"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"record_bgMusic_local"] forState:UIControlStateSelected];
    }
    self.button.selected = record.isPlaying;
}

@end
