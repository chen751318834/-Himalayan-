//
//  RCCommentViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCOneComment.h"
#import "RCOneParentComment.h"
@interface RCCommentViewCell : UITableViewCell
@property(nonatomic,strong) RCOneComment  *oneComment;
@property(nonatomic,strong) RCOneParentComment  *parentComment;
@end
