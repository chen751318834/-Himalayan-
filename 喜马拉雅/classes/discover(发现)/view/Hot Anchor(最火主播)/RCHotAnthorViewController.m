//
//  RCHotAnthorViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAnthorViewController.h"
#import "RCHotAnchorVIewModel.h"
#import "MJRefresh.h"
#import "RCAnthorViewCell.h"
@interface RCHotAnthorViewController ()
@property(nonatomic,strong) RCHotAnchorVIewModel  *viewModel;
@end

@implementation RCHotAnthorViewController
-  (RCHotAnchorVIewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCHotAnchorVIewModel alloc]init];

    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最火主播";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.contents = self.viewModel.models;
}
- (void)loadNewData{

    [self.viewModel fetchNewHotAnchorDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];
}
- (void)loadMoreData{

    [self.viewModel fetchMoreHotAnchorDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];

    } failure:^{
        [self.tableView.gifFooter endRefreshing];

    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAnthorViewCell * cell = [RCAnthorViewCell cellWithTableView:tableView];
    cell.anthorList = [self.viewModel  rowAtIndexPathInTableView:indexPath];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
