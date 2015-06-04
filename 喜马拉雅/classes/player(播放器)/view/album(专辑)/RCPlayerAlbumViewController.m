//
//  RCPlayerAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerAlbumViewController.h"
#import "RCPlayerAlbum.h"
#import "RCPlayerVIewModel.h"
#import "UIImageView+WebCache.h"
#import "RCPlayerAlbumViewCell.h"
#import "RCPlayerView.h"
#import "RCAlbumDeailViewController.h"
#import "RCNavigationController.h"
#import "RCTabBarViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface RCPlayerAlbumViewController ()
@property(nonatomic,weak) UIButton   *button;
@property(nonatomic,strong) RCPlayerVIewModel  *viewmodel;

@end

@implementation RCPlayerAlbumViewController
-  (RCPlayerVIewModel *)viewmodel{
    if (!_viewmodel) {
        self.viewmodel = [[RCPlayerVIewModel alloc]init];
        self.viewmodel.trackId = self.playerInfo.trackId;

    }
    return _viewmodel;
}
//- (UIButton *)button
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView =[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCPlayerAlbumViewCell" bundle:nil] forCellReuseIdentifier:@"albumCell"];
    [self.viewmodel fetchPlayerAlbumWithSuccess:^{
        [self.tableView reloadData];
    } failure:^{

    }];
    
}
-(NSString *)segmentTitle{

    return @"相关专辑";
}


-(UIScrollView *)streachScrollView{

    return self.tableView;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCPlayerAlbumViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"albumCell" forIndexPath:indexPath];
    cell.album = self.viewmodel.albums[indexPath.row];
    return cell;


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewmodel.albums.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:@"albumCell" cacheByIndexPath:indexPath configuration:^(RCPlayerAlbumViewCell * cell) {
        cell.album = self.viewmodel.albums[indexPath.row];

    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCPlayerAlbum *album = self.viewmodel.albums[indexPath.row];
    RCAlbumDeailViewController * albumDeailVC = [[RCAlbumDeailViewController alloc]init];
    albumDeailVC.ID = album.albumId;
    [RCPlayerView pushViewController:albumDeailVC];
}
@end
