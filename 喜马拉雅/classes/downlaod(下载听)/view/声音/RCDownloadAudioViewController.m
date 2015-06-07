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
    [self.tableView removeHeader];
    [RCNotificationCenter addObserver:self selector:@selector(reload:) name:AudioDownloadFinishedNotification object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCDownloadAudioViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadNewData];
    [self setUpHeaderView];
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
- (void)delete:(UIButton *)button{

    DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示" contentText:@"确定要取消收藏？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
    alertView.leftBlock = ^{
        [self.contents removeAllObjects];
        [RCDownloadTool removeAllDownloadAudio];
        [self.tableView reloadData];
        [self.tableView removeFooter];
    };

}
- (void)sort:(UIButton *)button{


}
- (void)reload:(NSNotification *)note{
    RCTrackList * list = note.userInfo[AudioDownloadFinishedAudioNotificationName];
    [self.contents insertObject:list atIndex:0];
    [self.tableView reloadData];
}
- (void)loadNewData{
    [self.contents addObjectsFromArray:[RCDownloadTool downloadAudiosWithPage:0]];
    [self.tableView reloadData];
    self.tableView.backgroundColor = RCGlobalBg;
    [self.tableView.gifHeader endRefreshing];
    [self.tableView removeHeader];

}

- (void)loadMoreData{
    self.page ++;
    [self.contents addObjectsFromArray:[RCDownloadTool downloadAudiosWithPage:self.page]];
    [self.tableView reloadData];
    [self.tableView.gifFooter endRefreshing];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDownloadAudioViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.list = self.contents[indexPath.row];
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
@end
