//
//  RCHotAudioViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioViewController.h"
#import "RCHotAudioVIewModel.h"
#import "Toast+UIView.h"
#import "RCHotAudioViewCell.h"
#import "RCPlayerView.h"
#import "ReactiveCocoa.h"
#import "RCConst.h"
#import "RCDownloadTool.h"
#import "RCBottomPlayerButton.h"
#import "RCPlayerViewController.h"
@interface RCHotAudioViewController ()
@property(nonatomic,strong) RCHotAudioVIewModel  *viewModel;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,assign) NSUInteger courrentIndex;

@end

@implementation RCHotAudioViewController
-  (RCHotAudioVIewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCHotAudioVIewModel alloc]init];

    }
    return _viewModel;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门声音";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setUpSectionHeaderView];

    self.contents = self.viewModel.models;
}
- (void)setUpSectionHeaderView{

}
#pragma mark - 网络请求
- (void)loadNewData{

    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
        {
            [self.viewModel fetchNewHotAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
            } failure:^{
                [self.tableView.gifHeader endRefreshing];
            }];
        }
            break;
        case 1:
        {
            [self.viewModel  fetchNewWeekHotAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
            } failure:^{
                [self.tableView.gifHeader endRefreshing];

            }];
        }
            break;
        case 2:
        {
            [self.viewModel fetchNewLikeAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
            } failure:^{
                [self.tableView.gifHeader endRefreshing];

            }];
        }
            break;
        default:
            break;
    }

}
- (void)loadMoreData{
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
        {
            [self.viewModel fetchMoreHotAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];
            }];
        }
            break;
        case 1:
        {

            [self.viewModel fetchMoreWeekHotAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];

            }];

        }
            break;
        case 2:
        {
            [self.viewModel fetchMoreLikeAudioDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];

            }];

        }
            break;
        default:
            break;
    }

  }
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCHotAudioViewCell * cell = [RCHotAudioViewCell cellWithTableView:tableView];
    RCTrackList * audio = self.contents[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"最火",@"本周最热",@"最多赞"]];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    @weakify(self);
     [[segmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl * control) {
    @strongify(self);
         if (self.contents.count != 0) {

             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
         }
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.tableView.gifHeader beginRefreshing];

         });
         self.courrentIndex = control.selectedSegmentIndex;

     }];
    self.segmentControl = segmentControl;


    return segmentControl;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RCTrackList * audio = self.contents[indexPath.row];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (audio.trackId) {
        [[RCPlayerView playerView] showAnimationing:^{
            [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:audio.trackId,isLocalAudioNotificationName:@(NO)}];

        } completion:^{
        }];
    }

}
#pragma mark - 事件处理
@end
