//
//  RCDownloadAudioViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAudioViewController.h"
#import "DXAlertView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCDownloadTool.h"
#import "RCDownloadAudioViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RCConst.h"
#import "RCPlayerView.h"
static NSString * const ID = @"downloadedAudioCell";
@interface RCDownloadAudioViewController ()
@property(nonatomic,assign) NSUInteger page;
@property(nonatomic,weak) UIView   *contentView;
@end

@implementation RCDownloadAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotificationCenter];
    [self.tableView removeHeader];
    self.tableView.backgroundColor = RCGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:@"RCDownloadAudioViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadNewData];
    [self setUpHeaderView];
}
- (void)setupNotificationCenter{
    [RCNotificationCenter addObserver:self selector:@selector(reload:) name:AudioDownloadFinishedNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(deletedAllToReload) name:deleteAudioOrAlbumNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(deletedOneAudioToReload:) name:deleteOneAudioOrAlbumNotification object:nil];
}

- (void)setUpHeaderView{
    UIButton * deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_n"] forState:UIControlStateNormal];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_h"] forState:UIControlStateHighlighted];
    [deleteAllButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    deleteAllButton.frame = CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width/2, 44);

    UIButton * sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sortButton.backgroundColor = [UIColor clearColor];
    [sortButton setImage:[UIImage imageNamed:@"btn_downloadsound_list_n"] forState:UIControlStateNormal];
    [sortButton setImage:[UIImage imageNamed:@"btn_downloadsound_list_h"] forState:UIControlStateHighlighted];
    [sortButton addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    sortButton.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, 44);

    UIView * contentView  = [[UIView alloc]init];

    contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    [contentView addSubview:deleteAllButton];
    self.contentView = contentView;
    [contentView addSubview:sortButton];
    self.tableView.tableHeaderView = contentView;


}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDownloadAudioViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    RCTrackList * list = self.contents[indexPath.row];
    cell.list = list;

    @weakify(self);
    [[cell.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.contents removeObject:list];
        [RCDownloadTool removeDownloadAudio:list];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [RCNotificationCenter postNotificationName:deleteOneAudioOrAlbumNotification object:nil userInfo:@{deleteOneAudioOrAlbumNotificationName:list}];

            [tableView reloadData];
        });
    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.contentView.hidden = [RCDownloadTool downloadAudioCount] == 0;
    return self.contents.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCDownloadAudioViewCell *  cell) {
        cell.list = self.contents[indexPath.row];

    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RCTrackList * audio = self.contents[indexPath.row];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (audio.trackId) {
        [[RCPlayerView playerView] showAnimationing:^{
            [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:audio.trackId,isLocalAudioNotificationName:@(YES)}]; 

        } completion:^{
        }];
    }
}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self] ;
}
#pragma mark - 事件处理

- (void)loadNewData{
    if (self.downlaodAudios) {
        [self.contents addObjectsFromArray:self.downlaodAudios];
    }else{
        [self.contents addObjectsFromArray:[RCDownloadTool downloadAudiosWithPage:0]];

    }
    [self.tableView reloadData];
    [self.tableView.gifHeader endRefreshing];
    [self.tableView removeHeader];

}

- (void)loadMoreData{
    self.page ++;
    [self.contents addObjectsFromArray:[RCDownloadTool downloadAudiosWithPage:self.page]];
    [self.tableView reloadData];
    [self.tableView.gifFooter endRefreshing];
//    [self.contents enumerateObjectsUsingBlock:^(RCTrackList * list, NSUInteger idx, BOOL *stop) {
//    }];
}
-(void)deletedAllToReload{
    [self.contents removeAllObjects];
    [self.tableView reloadData];

}
- (void)delete:(UIButton *)button{

    DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示" contentText:@"确定要删除所有下载的声音吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
    alertView.leftBlock = ^{
        [self.contents removeAllObjects];
        [RCDownloadTool removeAllDownloadAlbum];
        [RCDownloadTool removeAllDownloadAudio];
        [self.tableView reloadData];
        [RCNotificationCenter postNotificationName:deleteAudioOrAlbumNotification object:nil];
        [self.tableView removeFooter];
    };

}
- (void)sort:(UIButton *)button{


}
- (void)deletedOneAudioToReload:(NSNotification *)note{
    RCTrackList * list = note.userInfo[deleteOneAudioOrAlbumNotificationName];
    [self.contents removeObject:list];
    [self.tableView reloadData];
}
- (void)reload:(NSNotification *)note{
    RCTrackList * trackList = note.userInfo[AudioDownloadFinishedAudioNotificationName];
    for (RCTrackList * list in self.contents) {
        if ([trackList.trackId isEqualToNumber:list.trackId]) {
            return;
        }
    }
    [self.contents insertObject:trackList atIndex:0];
    [self.tableView reloadData];
}
@end
