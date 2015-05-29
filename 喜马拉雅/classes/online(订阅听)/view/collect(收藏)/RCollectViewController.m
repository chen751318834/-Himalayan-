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
#import "RCCollectViewCell.h"
#import "RCAlbumTool.h"
#import "DXAlertView.h"
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
    [RCNotificationCenter addObserver:self selector:@selector(reloadAlbumData:) name:savedAlbumNotification object:nil];
    [self.viewModel loadNewAlbumsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:nil];}
- (void)reloadAlbumData:(NSNotification *)note{
    RCAlbum * album = note.userInfo[savedAlbumNotificationName];
    [self.viewModel.saveAlbumlists insertObject:album atIndex:0];
    [self.tableView reloadData];

}

- (void)loadMoreData{

    [self.viewModel loadMoreAlbumsWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:nil completion:nil];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCCollectViewCell * cell = [RCCollectViewCell cell];
    RCAlbum * album = [self.viewModel AlbumListAtIndexPath:indexPath];
    cell.album = album;
    @weakify(self);
    [[cell.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * butotn) {
        @strongify(self);
        DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示" contentText:@"确定要取消收藏？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
        [alertView show];
        alertView.leftBlock = ^{
            [self.viewModel.saveAlbumlists removeObject:album];
            [RCAlbumTool removealbum:album];
            [self.tableView reloadData];
        };
        


    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.gifFooter.hidden = self.viewModel.saveAlbumlists.count == [self.viewModel albumCount];
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
