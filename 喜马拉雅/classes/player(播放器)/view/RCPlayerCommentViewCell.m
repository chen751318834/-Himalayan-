//
//  RPlayerCommentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerCommentViewCell.h"

@implementation RCPlayerCommentViewCell
+ (instancetype)cell{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCPlayerCommentViewCell" owner:nil options:nil]lastObject];
}


@end
