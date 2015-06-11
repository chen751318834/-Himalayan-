//
//  RCUserDeailViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserDeailViewController.h"
#import "RCSearchViewModel.h"

#import "RCUserDeailViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
static NSString * const ID = @"userDeailCell";
@interface RCUserDeailViewController ()
@property(nonatomic,strong) RCSearchViewModel  *viewModel;

@end

@implementation RCUserDeailViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];
        self.viewModel.ID = self.ID;
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCUserDeailViewCell" bundle:nil] forCellReuseIdentifier:ID];
}
- (void)loadNewData{
    [self.viewModel fetchNewUserOfFollowerWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{

    }];

}

- (void)loadMoreData{

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCUserDeailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.list = self.viewModel.models[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCUserDeailViewCell * cell) {

    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
