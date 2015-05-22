//
//  RCHotActivityViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotActivityViewController.h"
#import "RCHotActivityViewCell.h"
#import "RCConst.h"
#import "RCHotActivityViewModel.h"
@interface RCHotActivityViewController ()
@property(nonatomic,strong) RCHotActivityViewModel  *viewModel;

@end

@implementation RCHotActivityViewController
-  (RCHotActivityViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCHotActivityViewModel alloc]init];
        self.contents = self.viewModel.models;

    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"喜马拉雅精彩活动";

}
- (void)loadNewData{
    [self.viewModel fetchNewDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];
    }];
}
- (void)loadMoreData{
    [self.viewModel fetchMoreDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];
    } completion:^{
        [[UIApplication sharedApplication].keyWindow makeToast:@"没有更多的数据了" duration:2 position:@"bottom"];
        self.tableView.gifFooter.hidden = YES;
    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCHotActivityViewCell * cell = [RCHotActivityViewCell cellWithTableView:tableView];
    cell.activity = self.contents[indexPath.row];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
