//
//  RCDownloadingAudioViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadingAudioViewController.h"
#import "RCConst.h"
#import "RCDownloadTool.h"
#import "RCDownloadingViewCell.h"
#import "RCTrackList.h"
#import "DXAlertView.h"
#import "LDProgressView.h"
#import "AFDownloadRequestOperation.h"

@interface RCDownloadingAudioViewController () <RCDownloadingViewCellDelegate>
@property(nonatomic,strong) AFDownloadRequestOperation  *downloadManager;
@property(nonatomic,assign) CGFloat percentDone;
@property(nonatomic,assign) long long totalBytesReadForFile;
@property(nonatomic,assign) long long totalBytesExpectedToReadForFile;
@property(nonatomic,weak) RCDownloadingViewCell   *cell;
@property(nonatomic,weak) UIView   *contentView;
@property(nonatomic,strong) NSTimer  *refreshTimer;

@end

@implementation RCDownloadingAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeFooter];
    [self.tableView removeHeader];
    self.tableView.backgroundColor = RCGlobalBg;
    [RCNotificationCenter addObserver:self selector:@selector(download:) name:downlaodNotification object:nil];
    [self.contents addObjectsFromArray:[RCDownloadTool downloadingAudios]];
    [self.tableView reloadData];
    [self setUpHeaderView];


   }
- (void)refreshProgress{
    self.percentDone = self.totalBytesReadForFile/self.totalBytesExpectedToReadForFile;

}
- (void)setUpHeaderView{
    UIButton * deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_n"] forState:UIControlStateNormal];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_h"] forState:UIControlStateHighlighted];
    [deleteAllButton addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
    deleteAllButton.frame = CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width/2, 44);

    UIButton * continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    continueButton.backgroundColor = [UIColor clearColor];
    [continueButton setImage:[UIImage imageNamed:@"btn_downloadsound_continue_n"] forState:UIControlStateNormal];
    [continueButton setImage:[UIImage imageNamed:@"btn_downloadsound_continue_h"] forState:UIControlStateHighlighted];
        [continueButton setImage:[UIImage imageNamed:@"btn_downloadsound_pause_n"] forState:UIControlStateSelected];
    //btn_downloadsound_pause_n
    [continueButton addTarget:self action:@selector(continueDownload:) forControlEvents:UIControlEventTouchUpInside];
    continueButton.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, 44);

    UIView * contentView  = [[UIView alloc]init];

    contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    [contentView addSubview:deleteAllButton];
    [contentView addSubview:continueButton];
    self.tableView.tableHeaderView = contentView;
    self.contentView = contentView;
    
}
- (void)deleteAll:(UIButton *)button{

    DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示" contentText:@"确定要取删除下载？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
    alertView.leftBlock = ^{
        [self.contents removeAllObjects];
        [RCDownloadTool removeAllDownloadingAudio];
        [self.tableView reloadData];
        [self.tableView removeFooter];
    };

}
- (void)continueDownload:(UIButton *)button{
    if (button.isSelected) {
        [self.downloadManager pause];
    }else{
        [self.downloadManager resume];

    }
    NSLog(@"%@",self.downloadManager);

    button.selected = !button.isSelected;
    
}


- (void)download:(NSNotification *)note{

    RCTrackList * tracklist = note.userInfo[downlaodNotificationName];

    [self.contents addObject:tracklist];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDownloadingViewCell * cell = [RCDownloadingViewCell cell];
    RCTrackList * list = self.contents[indexPath.row];
    cell.list = self.contents[indexPath.row];
    cell.delegate = self;
    [cell startDownloadWithTrackList:list];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.contentView.hidden = [RCDownloadTool downloadingAudioCount] == 0;

    return self.contents.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    RCDownloadingViewCell * cell = (  RCDownloadingViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    RCTrackList * list = self.contents[indexPath.row];


}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}
- (void)downloadingViewCell:(RCDownloadingViewCell *)cell trackList:(RCTrackList *)trackList progress:(NSNumber *)progress currentDownloadSize:(NSNumber *)currentDownloadSize totalDownloadSize:(NSNumber *)totalDownloadSize{
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fMB",  [totalDownloadSize longLongValue]/1024.0/1024.0];
    cell.downloadProgresslabel.text = [NSString stringWithFormat:@"%.2fMB/%.2fMB",  [currentDownloadSize longLongValue]/1024.0/1024.0,  [totalDownloadSize longLongValue]/1024.0/1024.0];
    self.totalBytesReadForFile = [currentDownloadSize longLongValue];
    self.totalBytesExpectedToReadForFile = [totalDownloadSize longLongValue];
    cell.progressView.progress = self.percentDone;
    self.refreshTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.refreshTimer forMode:NSRunLoopCommonModes];

}


-(void)downloadFinished:(RCDownloadingViewCell *)downloadingViewCell trackList:(RCTrackList *)trackList{
    [self.contents removeObject:trackList];
    [self.tableView reloadData];
}

- (void)downloadFail:(RCDownloadingViewCell *)downloadingViewCell {

}


@end
