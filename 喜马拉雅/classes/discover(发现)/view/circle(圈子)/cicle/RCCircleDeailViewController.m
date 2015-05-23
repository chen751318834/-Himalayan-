//
//  RCCircleDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCircleDeailViewController.h"
#import "RCCircleViewModel.h"
#import "RCCicleDeailViewCell.h"
#import "RCCicleDeailHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
static NSString * const ID = @"zonePostCell";
@interface RCCircleDeailViewController ()
@property(nonatomic,strong) RCCircleViewModel  *viewModel;

@end

@implementation RCCircleDeailViewController
-  (RCCircleViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCCircleViewModel alloc]init];
        self.viewModel.zoneID = self.zoneID;
        self.viewModel.timeline = self.timeline;
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"RCCicleDeailViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.viewModel fetchZonesAndPostDeailHeaderDataWithSuccess:^{
        RCCicleDeailHeaderView * headerView = [RCCicleDeailHeaderView headerView];
        headerView.data = self.viewModel.headData;
        self.tableView.tableHeaderView = headerView;
    } failure:^{

    }];
}
- (void)loadNewData{
    [self.viewModel fetchNewZonesAndPostDeailDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];
}

- (void)loadMoreData{
    [self.viewModel fetchMoreZonesAndPostDeailDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];
    } completion:nil];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCCicleDeailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.zonePost = [self.viewModel zonePostAtIndexPath:indexPath];
    return cell;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowOfZonePostInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCCicleDeailViewCell * cell) {
        cell.zonePost = [self.viewModel zonePostAtIndexPath:indexPath];

    }];

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
