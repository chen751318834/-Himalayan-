//
//  RCAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumViewController.h"
#import "RCAlbumViewCell.h"
#import "Toast+UIView.h"
#import "RCAlbumDeailViewController.h"
#import "RCAlbumTool.h"
#import "RCConst.h"
#import "RCAlbumViewModel.h"
@interface RCAlbumViewController ()
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,assign) NSUInteger currentIndex;
@property(nonatomic,strong) RCAlbumViewModel  *viewModel;

@end

@implementation RCAlbumViewController
-  (RCAlbumViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCAlbumViewModel alloc]init];
        self.contents = self.viewModel.models;


    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"推荐专辑";
}
#pragma mark - 网络请求
- (void)loadNewData{

    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
        {
            [self.viewModel fetchNewHotAlbumDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
            } failure:^{
                [self.tableView.gifHeader endRefreshing];
            }];
        }
            break;
        case 1:
        {
            [self.viewModel  fetchNewReccentAlbumDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifHeader endRefreshing];
            } failure:^{
                [self.tableView.gifHeader endRefreshing];

            }];
        }
            break;
        case 2:
        {
            [self.viewModel fetchNewClassicsDataWithSuccess:^{
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
            [self.viewModel fetchMoreHotAlbumDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];
            } completion:^{
                [[UIApplication sharedApplication].keyWindow makeToast:@"没有更多的数据了" duration:2 position:@"bottom"];
                self.tableView.gifFooter.hidden = YES;
            }];
        }
            break;
        case 1:
        {

            [self.viewModel fetchMoreReccentAlbumDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];

            }completion:^{
                [[UIApplication sharedApplication].keyWindow makeToast:@"没有更多的数据了" duration:2 position:@"bottom"];
                self.tableView.gifFooter.hidden = YES;
            }];

        }
            break;
        case 2:
        {
            [self.viewModel fetchMoreClassicsDataWithSuccess:^{
                [self.tableView reloadData];
                [self.tableView.gifFooter endRefreshing];
            } failure:^{
                [self.tableView.gifFooter endRefreshing];

            }completion:^{
                [[UIApplication sharedApplication].keyWindow makeToast:@"没有更多的数据了" duration:2 position:@"bottom"];
                self.tableView.gifFooter.hidden = YES;
            }];
            
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumViewCell * cell = [RCAlbumViewCell cell];
    RCAlbum * album = self.contents[indexPath.row];
    cell.album = album;
    [[cell.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * butotn) {
        album.collect = YES;
        [RCAlbumTool saveAlbum:album];
        [RCNotificationCenter postNotificationName:savedAlbumNotification object:nil];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"最火",@"最近更新",@"经典"]];
    segmentControl.selectedSegmentIndex = self.currentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    @weakify(self);
    [[segmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self);
        if (self.contents.count != 0) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.gifHeader beginRefreshing];

        });

        self.currentIndex = segmentControl.selectedSegmentIndex;
    }];
    self.segmentControl = segmentControl;


    return segmentControl;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCAlbum * album = self.contents[indexPath.row];
    RCAlbumDeailViewController * albumDeailVC = [[RCAlbumDeailViewController alloc]init];
    albumDeailVC.ID = album.ID;

    [self.navigationController pushViewController:albumDeailVC animated:YES];
    
}
- (void)dealloc{

    [RCNotificationCenter removeObserver:self];
}
@end
