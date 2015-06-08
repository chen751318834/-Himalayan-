//
//  RCDownloadAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAlbumViewController.h"
#import "RCDownloadAudioViewController.h"
#import "RCDownloadTool.h"
#import "RCDownloadAlbumViewCell.h"
#import "RCTrackList.h"
#include "DXAlertView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCNavigationController.h"
#import "RCConst.h"
static NSString * const ID = @"downloadAlbumViewCell.h";
@interface RCDownloadAlbumViewController ()
@property(nonatomic,weak) UIButton   *deleteAllButton;
@end

@implementation RCDownloadAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotificationCenter];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCDownloadAlbumViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView removeHeader];
    [self.tableView removeFooter];
    [self setUpHeaderView];
    self.tableView.backgroundColor = RCGlobalBg;
    [self.contents addObjectsFromArray:[RCDownloadTool downloadAlbums]];
    [self.tableView reloadData];


}
- (void)setupNotificationCenter{
    [RCNotificationCenter addObserver:self selector:@selector(reload:) name:AudioDownloadFinishedNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(deletedAllToReload) name:deleteAudioOrAlbumNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(deletedOneAlbumToReload:) name:deleteOneAudioOrAlbumNotification object:nil];

}
- (void)setUpHeaderView{

    UIButton * deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_n"] forState:UIControlStateNormal];
    [deleteAllButton setImage:[UIImage imageNamed:@"btn_downloadsound_clear_h"] forState:UIControlStateHighlighted];
    [deleteAllButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    deleteAllButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    self.deleteAllButton = deleteAllButton;
    self.tableView.tableHeaderView = deleteAllButton;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDownloadAlbumViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    RCTrackList * list = self.contents[indexPath.row];
    cell.list = list;
    @weakify(self);
    [[cell.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [RCDownloadTool removeDownloadAlbum:list];
        [self.contents removeObject:list];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [RCNotificationCenter postNotificationName:deleteOneAudioOrAlbumNotification object:nil userInfo:@{deleteOneAudioOrAlbumNotificationName:list}];

            [tableView reloadData];

        });



    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.deleteAllButton.hidden = [RCDownloadTool downloadAlbumCount] == 0;
    return self.contents.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCTrackList * list = self.contents[indexPath.row];
    NSArray * albums = [RCDownloadTool downloadAudiosWithAlbumId:list.albumId];
    RCDownloadAudioViewController * audioVC = [[RCDownloadAudioViewController alloc]init];
    audioVC.downlaodAudios = albums;
    audioVC.title = list.albumTitle;
    [[RCNavigationController navigationController] pushViewController:audioVC animated:YES];
}

#pragma mark - 事件处理
-(void)deletedAllToReload{
    [self.contents removeAllObjects];
    [self.tableView reloadData];

}
- (void)reload:(NSNotification *)note{
    RCTrackList * trackList = note.userInfo[AudioDownloadFinishedAudioNotificationName];
    for (RCTrackList * list in self.contents) {
        if ([trackList.albumId isEqualToNumber:list.albumId]) {
            list.audioCount++;
            trackList.audioCount = list.audioCount;
            [self.tableView reloadData];
            return;

        }
    }

    [self.contents insertObject:trackList atIndex:0];
    [RCDownloadTool saveDownloadAlbum:trackList];
    [self.tableView reloadData];
}
- (void)deletedOneAlbumToReload:(NSNotification *)note{
    RCTrackList * trackList = note.userInfo[deleteOneAudioOrAlbumNotificationName];
    [self.contents removeObject:trackList];
    [self.tableView reloadData];
}
- (void)delete:(UIButton *)button{

    DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示" contentText:@"确定要删除所有下载的专辑吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
    alertView.leftBlock = ^{
        [self.contents removeAllObjects];
        [RCDownloadTool removeAllDownloadAlbum];
        [RCDownloadTool removeAllDownloadAudio];
        [RCNotificationCenter postNotificationName:deleteAudioOrAlbumNotification object:nil];
        [self.tableView reloadData];
    };
    
    
}
@end
