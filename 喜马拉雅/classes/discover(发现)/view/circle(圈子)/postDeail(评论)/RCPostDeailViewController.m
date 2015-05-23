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
static NSString * const ID = @"commentCell";
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCCommentViewCell" bundle:nil] forCellReuseIdentifier:ID];
}
- (void)loadNewData{
    [self.viewModel fetchNewCommentsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
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

    RCCommentViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.oneComment = [self.viewModel commentAtIndexPath:indexPath];
    cell.parentComment = [self.viewModel parentCommentAtIndexPath:indexPath];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCCommentViewCell * cell) {
        cell.oneComment = [self.viewModel commentAtIndexPath:indexPath];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowOfCommentInSection:section] ;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
