//
//  RCPostDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPostDeailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCCommentViewCell.h"
#import "RCCircleViewModel.h"
#import "RCBuildingOnwerViewCell.h"
static NSString * const commentID = @"commentViewCell";
static NSString * const onwerID = @"buildingOnwerViewCell";
@interface RCPostDeailViewController ()
@property(nonatomic,strong) RCCircleViewModel  *viewModel;
@end

@implementation RCPostDeailViewController

-  (RCCircleViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCCircleViewModel alloc]init];
        self.viewModel.post = self.post;
    }
    return _viewModel;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.post.title;
    [self.tableView registerNib:[UINib nibWithNibName:@"RCCommentViewCell" bundle:nil] forCellReuseIdentifier:commentID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCBuildingOnwerViewCell" bundle:nil] forCellReuseIdentifier:onwerID];

    self.tableView.gifFooter.hidden = YES;
}
- (void)loadNewData{

    [self.viewModel fetchBulidingOnwerDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
        [self.viewModel fetchNewCommentsWithSuccess:^{
            [self.tableView reloadData];
            [self.tableView.gifHeader endRefreshing];
            self.tableView.gifFooter.hidden = NO;

        } failure:^{
            [self.tableView.gifHeader endRefreshing];
            
        }];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];

}
- (void)loadMoreData{
    [self.viewModel fetchMoreCommentsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];
    } completion:nil];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RCBuildingOnwerViewCell * cell = [tableView dequeueReusableCellWithIdentifier:onwerID forIndexPath:indexPath];
        cell.post = [self.viewModel onwerDataAtIndexPath:indexPath];
        return cell;
    }
    RCCommentViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentID forIndexPath:indexPath];
    cell.oneComment = [self.viewModel commentAtIndexPath:indexPath];

    return cell;

}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:onwerID cacheByIndexPath:indexPath configuration:^(RCBuildingOnwerViewCell * cell) {
            cell.post = [self.viewModel onwerDataAtIndexPath:indexPath];

        }];
    }
        return [tableView fd_heightForCellWithIdentifier:commentID cacheByIndexPath:indexPath configuration:^(RCCommentViewCell * cell) {
            cell.oneComment = [self.viewModel commentAtIndexPath:indexPath];
            
        }];



}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowOfCommentInSection:section] ;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}
@end
