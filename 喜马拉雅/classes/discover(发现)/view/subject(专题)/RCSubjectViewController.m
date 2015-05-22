//
//  RCSubjectViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSubjectViewController.h"
#import "RCSubjectViewModel.h"
#import "RCSubjectSectionHeaderView.h"
#import "RCSubjectViewCell.h"
@interface RCSubjectViewController ()
@property(nonatomic,strong) RCSubjectViewModel  *viewModel;

@end

@implementation RCSubjectViewController
-  (RCSubjectViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSubjectViewModel alloc]init];
        self.contents = self.viewModel.models;

    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.gifFooter setHidden:NO];
    self.title = @"专题";

}
- (void)loadNewData{
    [self.viewModel fetchNewSubjectDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];

}

- (void)loadMoreData{
    [self.viewModel fetchMoreSubjectDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];

    } failure:^{
        [self.tableView.gifFooter endRefreshing];

    }];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCSubjectViewCell * cell = [RCSubjectViewCell cellWithTableView:tableView];
    cell.list = self.contents[indexPath.section];
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RCSubjectSectionHeaderView * headerView = [RCSubjectSectionHeaderView headerView];
    RCSubjectList * list = self.contents[section];
    [headerView.titleButton setTitle:[NSString stringWithFormat:@"%@",list.releasedAt ]forState:UIControlStateNormal];

    return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contents.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 141;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
