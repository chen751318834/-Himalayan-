//
//  RCAboutAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAboutAlbumViewController.h"
#import "RCAlbumViewModel.h"
#import "ReactiveCocoa.h"
#import "RCAlbumTool.h"
#import "KVNProgress.h"
#import "RCAlbumViewCell.h"
#import "RCConst.h"
@interface RCAboutAlbumViewController ()
@property(nonatomic,strong) RCAlbumViewModel  *viewModel;

@end

@implementation RCAboutAlbumViewController
-  (RCAlbumViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCAlbumViewModel alloc]init];
        self.viewModel.albumId = self.albumId;
    }
    return _viewModel;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"loading..."}];

    [self.viewModel fetchAboutAlbumWithSuccess:^{
        [self.tableView reloadData];
        [KVNProgress dismiss];
    } failure:^{
        [KVNProgress dismiss];

    }];
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumViewCell * cell = [RCAlbumViewCell cell];
    RCAlbum * album = [self.viewModel aboutAlbumListAtIndexPath:indexPath];
    cell.album = album;
    @weakify(self);
    [[cell.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *button) {
        @strongify(self);
        album.collect = YES;
        [RCAlbumTool saveAlbum:album];
        NSMutableDictionary * info = [NSMutableDictionary dictionary];
        if (album) {
            info[albumNotificationName] = album;
            info[isCollectedAlbumNotificationName] = @YES;
        }
        [RCNotificationCenter postNotificationName:savedAlbumNotification object:nil userInfo:info];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowOfAboutAlbumlistInSection:section];
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
