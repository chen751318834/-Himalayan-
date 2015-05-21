//
//  RCHotAudioViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioViewController.h"
#import <ReactiveCocoa/metamacros.h>
#import "RCHotAudioVIewModel.h"
#import "RCHotAudioViewCell.h"
#import "RCConst.h"
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
    cell.audio = self.contents[indexPath.row];
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
    segmentControl.tintColor = [UIColor colorWithRed:0.983 green:0.000 blue:0.257 alpha:1.000];
    @weakify(self);
    [[segmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        [self.tableView.gifHeader beginRefreshing];
        @strongify(self);
        self.courrentIndex = segmentControl.selectedSegmentIndex;
    }];
    self.segmentControl = segmentControl;


    return segmentControl;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 事件处理
@end
