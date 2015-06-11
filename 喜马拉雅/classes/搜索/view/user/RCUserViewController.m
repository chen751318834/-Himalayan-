//
//  RCUserViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCUserInfoHeaderView.h"
#import "RCSearchViewModel.h"
#import "UIView+JHChainableAnimations.h"
#import "RCDownloadTool.h"
#import "ReactiveCocoa.h"
#import "RCAlbumViewCell.h"
#import "RCConst.h"
#import "RCPlayerView.h"
#import "RCAlbumTool.h"
#import "RCAlbumDeailViewController.h"
#import "RCHotAudioViewCell.h"
#import "Toast+UIView.h"
#import "UIImage+RC.h"
static NSString * const ID = @"userCell";
@interface RCUserViewController ()
@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@property(nonatomic,weak) RCUserInfoHeaderView   *headerView;

@end

@implementation RCUserViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];
        self.viewModel.ID = self.ID;
    }
    return _viewModel;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.makeOpacity(0.3).animate(0.5);
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.makeOpacity(1).animate(0.5);
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 46, 0);
    self.tableView.backgroundColor = RCGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:@"RCSearchReslultUserViewCell" bundle:nil] forCellReuseIdentifier:ID];
    RCUserInfoHeaderView * headerView = [RCUserInfoHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}
- (void)loadNewData{
    [self.viewModel fetchUserInfoWithSuccess:^{
        self.headerView.userInfo = self.viewModel.userInfo;
        [self.viewModel fetchUserAlbumsWithSuccess:^{
            [self.viewModel fetchUserAudiosWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
                [self.tableView removeHeader];
            } failure:^{
                
            } completion:^{
                
            }];
        } failure:^{
            
        }];

    } failure:^{

    }];

}

- (void)loadMoreData{

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RCAlbumViewCell * cell = [RCAlbumViewCell cell];
        RCAlbum * album = self.viewModel.userAlbums[indexPath.row];
        cell.album = album;
        @weakify(self);
        [[cell.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * butotn) {
            @strongify(self);
            album.collect = YES;
            [RCAlbumTool saveAlbum:album];
            NSMutableDictionary * info = [NSMutableDictionary dictionary];
            if (album) {
                info[albumNotificationName] = album;
                info[isCollectedAlbumNotificationName] = @YES;
            }
            [RCNotificationCenter postNotificationName:savedAlbumNotification object:nil userInfo:info];

            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        }];
        return cell;
    }
    RCHotAudioViewCell * cell = [RCHotAudioViewCell cellWithTableView:tableView];
     RCTrackList * audio = self.viewModel.userAudios[indexPath.row];
    cell.audio = audio;
    cell.searchUserInfo = self.viewModel.userInfo;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
return @"发布的专辑";
    }

    return @"发布的声音";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.viewModel.userAlbums.count;
    }
    return self.viewModel.userAudios.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }
    return 105;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        RCAlbum * album = self.viewModel.userAlbums[indexPath.row];
        RCAlbumDeailViewController * albumDeailVC = [[RCAlbumDeailViewController alloc]init];
        albumDeailVC.ID = album.albumId;

        [self.navigationController pushViewController:albumDeailVC animated:YES];
    }else{
        RCTrackList * audio = self.viewModel.userAudios[indexPath.row];
         if (audio.trackId) {
        [[RCPlayerView playerView] showAnimationing:^{
                [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:audio.trackId}];
        } completion:nil];

         }else{
             [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"正在加载..."}];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [KVNProgress dismiss];
                 [KVNProgress showErrorWithStatus:@"播放的声音不存在..."];

             });
         }
    }
}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self] ;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{


}

@end
