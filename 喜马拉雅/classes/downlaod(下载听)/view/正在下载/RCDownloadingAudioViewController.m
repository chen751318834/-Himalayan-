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
#import "EAColourfulProgressView.h"
#import "AFDownloadRequestOperation.h"
@interface RCDownloadingAudioViewController ()
@property(nonatomic,strong) AFDownloadRequestOperation  *downloadManager;
@property(nonatomic,assign) float percentDone;
@property(nonatomic,assign) long long totalBytesReadForFile;
@property(nonatomic,assign) long long totalBytesExpectedToReadForFile;
@property(nonatomic,weak) RCDownloadingViewCell   *cell;
@property(nonatomic,weak) UIView   *contentView;

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
        [RCDownloadTool removeAllDownloadAudio];
        [self.tableView reloadData];
        [self.tableView removeFooter];
    };

}
- (void)continueDownload:(UIButton *)button{
    
    
}
- (void)download:(NSNotification *)note{

    RCTrackList * tracklist = note.userInfo[downlaodNotificationName];
    [RCNotificationCenter postNotificationName:AudioDownloadFinishedNotification object:nil userInfo:@{AudioDownloadFinishedAudioNotificationName:tracklist}];


    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",tracklist.title]];
    self.downloadManager = [[AFDownloadRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tracklist.playPath64]] fileIdentifier:@"download" targetPath:path shouldResume:YES];
    [self.downloadManager start];
    [RCDownloadTool saveDownloadingAudio:tracklist];
    [self.contents addObject:tracklist];
    [self.tableView reloadData];
    __weak typeof(self) weakSelf = self;
    //创建多线程第六种方式
    dispatch_queue_t queue = dispatch_queue_create("name", NULL);
    dispatch_async(queue, ^{
        [self.downloadManager setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
            float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
            weakSelf.percentDone = percentDone;
            weakSelf.totalBytesReadForFile = totalBytesReadForFile;
            weakSelf.totalBytesExpectedToReadForFile = totalBytesExpectedToReadForFile;
            [weakSelf.tableView reloadData];
                  }];
    });
    [self.downloadManager setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        tracklist.downloadSize =@(weakSelf.totalBytesExpectedToReadForFile);
        [RCDownloadTool saveDownloadAudio:tracklist];
        [RCDownloadTool saveDownloadAlbum:tracklist];
        [RCDownloadTool removeDownloadingAudio:tracklist];
        [RCNotificationCenter postNotificationName:AudioDownloadFinishedNotification object:nil userInfo:@{AudioDownloadFinishedAudioNotificationName:tracklist}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    NSLog(@"%@",change);
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDownloadingViewCell * cell = [RCDownloadingViewCell cell];
    self.cell = cell;
    cell.list = self.contents[indexPath.row];
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fMB",self.totalBytesExpectedToReadForFile/1024.0/1024.0];
    cell.downloadProgresslabel.text = [NSString stringWithFormat:@"%.2fMB/%.2fMB",self.totalBytesReadForFile/1024.0/1024.0,self.totalBytesExpectedToReadForFile/1024.0/1024.0];
    [cell.downloadProgressView updateToCurrentValue:(NSInteger)self.percentDone animated:YES];
  
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.contentView.hidden = [RCDownloadTool downloadAudioCount] == 0;

    return self.contents.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}
@end
