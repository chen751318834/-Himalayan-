//
//  RCAnthorImgeView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAnthorImgeView.h"

@implementation RCAnthorImgeView

- (void)awakeFromNib{
    self.layer.borderWidth = 1.5;
    self.layer.borderColor = [UIColor colorWithWhite:0.500 alpha:0.670].CGColor;
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowOpacity = 1;
}


@end
