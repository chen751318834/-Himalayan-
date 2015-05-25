//
//  SegementButton.m
//  QQZone
//
//  Created by Raychen on 14/12/28.
//  Copyright (c) 2014年 raychen. All rights reserved.
//

#import "SegementButton.h"

@implementation SegementButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
    
    
}
- (void)setHighlighted:(BOOL)highlighted{}
@end
