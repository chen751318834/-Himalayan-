//
//  RCPlayerHeaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCPlayerHeaderViewCell;


@protocol RCPlayerHeaderViewCellDelegate <NSObject>

@optional
- (void)back:(RCPlayerHeaderViewCell *)headerViewCell;

@end
@interface RCPlayerHeaderViewCell : UITableViewCell
+ (instancetype)cell;
@property(nonatomic,weak) id<RCPlayerHeaderViewCellDelegate>   delegate;
@property(nonatomic,strong) NSArray  *audios;
@end
