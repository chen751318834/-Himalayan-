//
//  RCOneAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOneAlbumViewController.h"
#import "RCAlbumViewModel.h"
#import "RCAlbumViewCell.h"
@interface RCOneAlbumViewController ()
@property(nonatomic,strong) RCAlbumViewModel  *viewModel;

@end

@implementation RCOneAlbumViewController
-  (RCAlbumViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCAlbumViewModel alloc]init];
        self.contents = self.viewModel.models;
        self.viewModel.tag = self.tag;
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.tag;
}
- (void)loadNewData{
    [self.viewModel fetchNewTagAlbumWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];

}

- (void)loadMoreData{
    [self.viewModel fetchMoreTagAlbumWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];

    } completion:^{
        [self.tableView.gifFooter endRefreshing];
        [self.tableView removeFooter];

    }];

}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumViewCell * cell = [RCAlbumViewCell cell];
    cell.album = self.contents[indexPath.row];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contents.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
