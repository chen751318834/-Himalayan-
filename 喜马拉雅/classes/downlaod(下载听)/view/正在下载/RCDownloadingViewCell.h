//
//  RCDownloadingViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTrackList.h"
#import "LDProgressView.h"

@class RCDownloadingViewCell;
@protocol RCDownloadingViewCellDelegate <NSObject>
- (void)downloadingViewCell:(RCDownloadingViewCell *)cell;
- (void)downloadingViewCell:(RCDownloadingViewCell *)cell trackList:(RCTrackList *)trackList progress:(NSNumber *)progress currentDownloadSize:(NSNumber *)currentDownloadSize totalDownloadSize:(NSNumber *)totalDownloadSize;
-(void)downloadFinished:(RCDownloadingViewCell *)downloadingViewCell trackList:(RCTrackList *)trackList;
-(void)downloadFail:(RCDownloadingViewCell *)downloadingViewCell;

@end
@interface RCDownloadingViewCell : UITableViewCell

@property(nonatomic,strong) RCTrackList  *list;
+ (instancetype)cell;
@property (weak, nonatomic)IBOutlet  UIProgressView *progressView;

@property(nonatomic,weak) id<RCDownloadingViewCellDelegate>  delegate;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *downloadProgresslabel;
@property(nonatomic,strong) NSURL  *url ;

- (void)startDownloadWithTrackList:(RCTrackList *)trackList;

@end
