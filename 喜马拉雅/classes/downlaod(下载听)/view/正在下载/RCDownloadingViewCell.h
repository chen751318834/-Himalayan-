//
//  RCDownloadingViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTrackList.h"
#import "EAColourfulProgressView.h"
@class RCDownloadingViewCell;
@protocol RCDownloadingViewCellDelegate <NSObject>
- (void)downloadingViewCell:(RCDownloadingViewCell *)cell;
@end
@interface RCDownloadingViewCell : UITableViewCell

@property(nonatomic,strong) RCTrackList  *list;
+ (instancetype)cell;

@property(nonatomic,weak) id<RCDownloadingViewCellDelegate>  delegate;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet EAColourfulProgressView *downloadProgressView;
@property (weak, nonatomic) IBOutlet UILabel *downloadProgresslabel;

@end
