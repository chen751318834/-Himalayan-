//
//  RCCircleDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCircleDeailViewController.h"
#import "RCPostDeailViewController.h"
#import "RCCircleViewModel.h"
#import "UIImageView+WebCache.h"
#import "RCCicleDeailHeaderView.h"
#import "RCRecommendPostViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
static NSString * const ID = @"postCell";
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
    [self.tableView.gifFooter  setHidden:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCRecommendPostViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"topCell"];
    [self.viewModel fetchZonesAndPostDeailHeaderDataWithSuccess:^{
        RCCicleDeailHeaderView * headerView = [RCCicleDeailHeaderView headerView];
        headerView.zone = self.viewModel.headData;
        self.tableView.tableHeaderView = headerView;
        self.title = [self.viewModel headData].displayName;
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
    if (indexPath.section == 0) {
        RCRecommendedPost * topPost = [self.viewModel topZonePostAtIndexPath:indexPath];
    static NSString * topPostID = @"topCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:topPostID forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:topPostID];
        }
        cell.imageView.image = [UIImage imageNamed:@"topic_top"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = topPost.title;

        return cell;
    }
    RCRecommendPostViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.post = [self.viewModel zonePostAtIndexPath:indexPath];
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.gifFooter.hidden = [self.viewModel numberOfRowOfZonePostInSection:section] == 0;
    return [self.viewModel numberOfRowOfZonePostInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 30;
    }
    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCRecommendPostViewCell * cell) {
        cell.post = [self.viewModel zonePostAtIndexPath:indexPath];

    }];

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCRecommendedPost * post = [self.viewModel postAtIndexPath:indexPath];
    RCPostDeailViewController * postDeailVC = [[RCPostDeailViewController alloc]init];
    postDeailVC.post = post;
    [self.navigationController pushViewController:postDeailVC animated:YES];

}
@end
