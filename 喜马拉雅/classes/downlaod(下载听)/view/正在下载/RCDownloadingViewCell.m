//
//  RCDownloadingViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadingViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCAlbum.h"
#import "AFDownloadRequestOperation.h"
#import "RCConst.h"
#import "RCDownloadTool.h"
@interface RCDownloadingViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *sourelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *sayCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeLeghtLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadStateButton;
@property(nonatomic,strong) AFDownloadRequestOperation  *downloadManager;
@property(nonatomic,assign) CGFloat percentDone;
@property(nonatomic,assign) long long totalBytesReadForFile;
@property(nonatomic,assign) long long totalBytesExpectedToReadForFile;

@end
@implementation RCDownloadingViewCell
+ (instancetype)cell{
    // Initialization code
//    _downloadedData = nil;
//    _downloadURL = url;
//    _download = [[SGdownloader alloc] initWithURL:url timeout:60];


    return [[[NSBundle mainBundle]loadNibNamed:@"RCDownloadingViewCell" owner:nil options:nil]lastObject];
}

- (void)setList:(RCTrackList *)list{
    _list = list;
    NSLog(@"%@",list.playUrl32);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.coverSmall] placeholderImage:[UIImage imageNamed:@"findsection_sound_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if ([list.userSource  isEqual: @1]) {
        self.timelabel.text = [NSString stringWithFormat:@"%@ 原创",list.created_at];

    }else{
        self.timelabel.text = [NSString stringWithFormat:@"%@ 采集",list.created_at];

    }
    self.sourelabel.text = list.albumTitle;
    self.titlelabel.text = list.title;
    [self.timeLeghtLabel setTitle:[NSString stringWithFormat:@"%.2ld:%.2ld", [list.duration integerValue]/60,[list.duration  integerValue]%60] forState:UIControlStateNormal];
    [self setUpWithButton:self.playCountLabel count:[list.playsCounts intValue] title:nil];
    [self setUpWithButton:self.saveCountLabel count:[list.sharesCounts intValue] title:nil];
    [self setUpWithButton:self.sayCountLabel count:[list.commentsCounts intValue] title:nil];
        //    self.sizeLabel.text = [NSString stringWithFormat:@"%.2fMB",list.totalBytesExpectedToReadForFile/1024.0/1024.0];
//    self.downloadProgresslabel.text = [NSString stringWithFormat:@"%.2fMB/%.2fMB",list.totalBytesReadForFile/1024.0/1024.0,list.totalBytesExpectedToReadForFile/1024.0/1024.0];
//    self.progressView.progress = list.percentDone;
//    [self startDownload:list];
  }

- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{

        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

        //大于14000  -> 1.4万

        //大于10445  -> 1万
        [button setTitle:title forState:UIControlStateNormal];
        
        
    }
    
}
- (void)startDownload:(RCTrackList *)tracklist {
  //    [self.downloadManager start];

}

- (void)startDownloadWithTrackList:(RCTrackList *)trackList{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",trackList.title]];
    self.downloadManager = [[AFDownloadRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:trackList.playPath64?trackList.playPath64:trackList.playUrl32]] fileIdentifier:@"AudioOrAlbumdownloaded" targetPath:path shouldResume:YES];

    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("name", NULL);
    dispatch_async(queue, ^{
        [self.downloadManager setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
            CGFloat percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
            dispatch_async(dispatch_get_main_queue(), ^{
//                trackList.percentDone = percentDone;
//                trackList.totalBytesReadForFile = totalBytesReadForFile;
//                trackList.totalBytesExpectedToReadForFile = totalBytesExpectedToReadForFile;
//                weakSelf.sizeLabel.text = [NSString stringWithFormat:@"%.2fMB",totalBytesExpectedToReadForFile/1024.0/1024.0];
//                weakSelf.downloadProgresslabel.text = [NSString stringWithFormat:@"%.2fMB/%.2fMB",totalBytesReadForFile/1024.0/1024.0,totalBytesExpectedToReadForFile/1024.0/1024.0];
//                weakSelf.progressView.progress = percentDone;
                if ([weakSelf.delegate respondsToSelector:@selector(downloadingViewCell:trackList:progress:currentDownloadSize:totalDownloadSize:)]) {
                    [weakSelf.delegate downloadingViewCell:weakSelf trackList:trackList progress:@(percentDone) currentDownloadSize:@(totalBytesReadForFile) totalDownloadSize:@(totalBytesExpectedToReadForFile)];
                }
            });

        }];

    });


    [self.downloadManager setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        trackList.downloadSize =@(weakSelf.totalBytesExpectedToReadForFile);
        [RCDownloadTool saveDownloadAudio:trackList];
        [RCDownloadTool saveDownloadAlbum:trackList];
        [RCDownloadTool removeDownloadingAudio:trackList];
        [RCNotificationCenter postNotificationName:AudioDownloadFinishedNotification object:nil userInfo:@{AudioDownloadFinishedAudioNotificationName:trackList}];
        if ([weakSelf.delegate respondsToSelector:@selector(downloadFinished:trackList:)]) {
            [weakSelf.delegate downloadFinished:weakSelf trackList:trackList] ;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([weakSelf.delegate respondsToSelector:@selector(downloadFail:)]) {
            [weakSelf.delegate downloadFail:weakSelf];
        }
        NSLog(@"%@",error);
    }];

    [self.downloadManager start];
}
@end
