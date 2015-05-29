//
//  RCollectViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCollectViewController.h"
#import "RCConst.h"
#import "RCCollectViewModel.h"
#import "RCAlbumViewCell.h"
@interface RCollectViewController ()
@property(nonatomic,strong) RCCollectViewModel  *viewModel;
@end

@implementation RCollectViewController
-  (RCCollectViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCCollectViewModel alloc]init];

    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.gifHeader.hidden = YES;
    self.tableView.gifFooter.hidden = NO;
    [RCNotificationCenter addObserver:self selector:@selector(reloadAlbumData) name:savedAlbumNotification object:nil];

}
- (void)reloadAlbumData{
    [self.viewModel loadNewAlbumsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:nil];

}

- (void)loadMoreData{

    [self.viewModel loadMoreAlbumsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:nil completion:nil];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumViewCell * cell = [RCAlbumViewCell cell];
    RCAlbum * album = [self.viewModel AlbumListAtIndexPath:indexPath];
    cell.album = album;
    [[cell.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * butotn) {
        album.collect = YES;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.gifFooter.hidden = [self.viewModel numberOfRowAlbumlistInSection:section] == [self.viewModel albumCount];
    return [self.viewModel numberOfRowAlbumlistInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)dealloc{

    [RCNotificationCenter removeObserver:self];
}
@end
