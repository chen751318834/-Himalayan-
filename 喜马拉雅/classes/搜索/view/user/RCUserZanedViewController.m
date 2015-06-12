//
//  RCUserZanedViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserZanedViewController.h"
#import "RCHotAudioViewCell.h"
#import "RCDownloadTool.h"
#import "ReactiveCocoa.h"
#import "RCPlayerView.h"
#import "Toast+UIView.h"
#import "RCSearchViewModel.h"
#import "RCConst.h"
@interface RCUserZanedViewController ()
@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@end

@implementation RCUserZanedViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];
        self.viewModel.ID = self.ID;
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadNewData{
    self.tableView.gifFooter.hidden = YES;
    [self.viewModel fetchNewUserZanedWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
        self.tableView.gifFooter.hidden = NO;

    } failure:^{
        [self.tableView.gifHeader endRefreshing];
        self.tableView.gifFooter.hidden = NO;

    }];

}

- (void)loadMoreData{
    [self.viewModel fetchMoreUserZanedWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];

    } completion:^{
        [self.tableView removeFooter];
    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCHotAudioViewCell * cell = [RCHotAudioViewCell cellWithTableView:tableView];
    RCTrackList * audio = self.viewModel.models[indexPath.row];
    cell.audio = audio;
    @weakify(self);
    [[cell.downloadButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [RCDownloadTool saveDownloadingAudio:audio];
        [[UIApplication sharedApplication].keyWindow makeToast:@"加入下载队列成功" duration:1 position:@"bottom"];
        [RCNotificationCenter postNotificationName:downlaodNotification object:nil userInfo:@{downlaodNotificationName:audio}];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RCTrackList * list = self.viewModel.models[indexPath.row];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [[RCPlayerView playerView] showAnimationing:^{
        [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:list.trackId}];

    } completion:^{

    }];
}

@end
