//
//  RCCircleViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCircleViewController.h"
#import "RCCircleViewModel.h"
#import "RCRecommendPostViewCell.h"
#import "RCPostDeailViewController.h"
#import "RCRecommendZoneViewCell.h"
#import "RCCircleDeailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
static NSString * const zoneID = @"zoneCell";
static NSString * const postID = @"postCell";
@interface RCCircleViewController ()
@property(nonatomic,strong) RCCircleViewModel  *viewModel;

@end

@implementation RCCircleViewController
-  (RCCircleViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCCircleViewModel alloc]init];

    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈子";
    [self.tableView registerNib:[UINib nibWithNibName:@"RCRecommendZoneViewCell" bundle:nil] forCellReuseIdentifier:zoneID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCRecommendPostViewCell" bundle:nil] forCellReuseIdentifier:postID];
    self.tableView.gifFooter.hidden = YES;

}
- (void)loadNewData{

    [self.viewModel fetchRecommendZoneDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
        [self.viewModel fetchRecommendPostDataWithSuccess:^{
            [self.tableView reloadData];

            [self.tableView.gifHeader endRefreshing];

        } failure:^{
            [self.tableView.gifHeader endRefreshing];
            
        }];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];


}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==  0) {
        RCRecommendZoneViewCell * cell = [tableView dequeueReusableCellWithIdentifier:zoneID forIndexPath:indexPath];
       RCRecommendedZones * zone = [self.viewModel zoneAtIndexPath:indexPath];
        cell.zone  = zone;
        @weakify(self);
        [[cell.joinButon rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
            @strongify(self);
            zone.join = YES;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }];
        return cell;
    }
    RCRecommendPostViewCell * cell = [tableView dequeueReusableCellWithIdentifier:postID forIndexPath:indexPath];
    cell.post = [self.viewModel postAtIndexPath:indexPath];
    return cell;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.viewModel titleOfRowInSection:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 96;
    }
    return [tableView fd_heightForCellWithIdentifier:postID cacheByIndexPath:indexPath configuration:^(RCRecommendPostViewCell * cell) {
            cell.post = [self.viewModel postAtIndexPath:indexPath];
        }];


}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        RCRecommendedZones * zone = [self.viewModel zoneAtIndexPath:indexPath];
        RCCircleDeailViewController * cicleDeailVC = [[RCCircleDeailViewController alloc]init];
        cicleDeailVC.zoneID = zone.ID;
        cicleDeailVC.timeline = zone.timeline;
        [self.navigationController pushViewController:cicleDeailVC animated:YES];
    }else{
        RCPostDeailViewController * postDeailVC = [[RCPostDeailViewController alloc]init];
        RCRecommendedPost * post = [self.viewModel postAtIndexPath:indexPath];
        postDeailVC.post  = post;
        [self.navigationController pushViewController:postDeailVC animated:YES];

    }

}

@end
