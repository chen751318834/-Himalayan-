//
//  RCCommnetTextView.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCommnetTextView.h"

@implementation RCCommnetTextView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    self.editable = NO;
    self.scrollEnabled = NO;
}
@end
