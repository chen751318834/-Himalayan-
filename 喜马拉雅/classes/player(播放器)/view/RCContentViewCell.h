//
//  RCContentViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCContentViewCell;

@protocol RCContentViewCellDelegate <NSObject>

@optional
- (void)didScroll:(RCContentViewCell *)contentCell offfset:(CGPoint )offset;
@end
@interface RCContentViewCell : UITableViewCell
+ (instancetype)cell;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,weak) id<RCContentViewCellDelegate>   delegate;

@end
