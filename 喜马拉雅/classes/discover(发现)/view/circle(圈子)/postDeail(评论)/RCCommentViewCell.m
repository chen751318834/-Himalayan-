
//
//  RCCommentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCommentViewCell.h"

@implementation RCCommentViewCell

- (void)setOneComment:(RCOneComment *)oneComment{


    _oneComment = oneComment;
}
- (void)setParentComment:(RCOneParentComment *)parentComment{
    _parentComment = parentComment;
}
@end
