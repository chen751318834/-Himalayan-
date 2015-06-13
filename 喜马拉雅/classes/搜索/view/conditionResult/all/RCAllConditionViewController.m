//
//  RCAllConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAllConditionViewController.h"
#import "RCSearchConditionViewModel.h"
#import "RCConst.h"
#import "RCPlayerView.h"
#import "RCConditionResponseDoc.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCAllConditionSectionheaderView.h"
#import "RCUserViewController.h"
#import "RCAlbumDeailViewController.h"
#import "RCAllConditionUserViewCell.h"
#import "RCAllConditionAlbumViewCell.h"
#import "RCAllConditionTrackViewCell.h"
static NSString * const albumID = @"albumID";
static NSString * const userID = @"userID";
static NSString * const trackID = @"trackID";
@interface RCAllConditionViewController ()
@property(nonatomic,strong) RCSearchConditionViewModel  *viewModel;
@property(nonatomic,weak) RCAllConditionSectionheaderView   *sectionHeaderView;
@property(nonatomic,copy) NSString  *condition;

@end

@implementation RCAllConditionViewController
-  (RCSearchConditionViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCSearchConditionViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCAllConditionAlbumViewCell" bundle:nil] forCellReuseIdentifier:albumID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCAllConditionUserViewCell" bundle:nil] forCellReuseIdentifier:userID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCAllConditionTrackViewCell" bundle:nil] forCellReuseIdentifier:trackID];
    [RCNotificationCenter addObserver:self selector:@selector(getCondition:) name:sendSearchConditionNotification object:nil];
}
- (void)getCondition:(NSNotification *)note{
    [KVNProgress showWithStatus:@"正在加载..."];
    [self.viewModel fetchNewAllWithCondition:note.userInfo[sendSearchConditionNotificationName] success:^{
        [self.tableView reloadData];
        [KVNProgress dismiss];
    } failure:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress dismiss];
            [KVNProgress showError];

        });
    }];

    self.condition = note.userInfo[sendSearchConditionNotificationName];
}
- (void)loadMoreData{
    self.tableView.gifFooter.hidden = NO;
    [self.viewModel fetchMoreAllWithCondition:nil success:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{

    } completion:^{

    }];

}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RCAllConditionAlbumViewCell * cell = [tableView dequeueReusableCellWithIdentifier:albumID forIndexPath:indexPath];
        cell.doc = self.viewModel.albums[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        RCAllConditionUserViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userID forIndexPath:indexPath];
        cell.doc = self.viewModel.users[indexPath.row];
        return cell;
    }
    RCAllConditionTrackViewCell * cell = [tableView dequeueReusableCellWithIdentifier:trackID forIndexPath:indexPath];
    cell.doc = self.viewModel.tracks[indexPath.row];
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.viewModel.albums.count == 0?0:40;
    }else if (section == 1){
        return self.viewModel.users.count == 0?0:40;
    }
    return self.viewModel.tracks.count == 0?0:40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RCAllConditionSectionheaderView * sectionHeaderView = [RCAllConditionSectionheaderView sectionHeaderView];
    self.sectionHeaderView = sectionHeaderView;
    NSString * imageName = nil;
    NSString * dataTypeStr = nil;
    NSString * resultCountStr = nil;
    if (section == 0) {
        imageName = @"scopeAlbum_icon";
        dataTypeStr = @"专辑";
        resultCountStr = [NSString stringWithFormat:@"全部%@条结果",self.viewModel.album.numFound];
    }else if (section == 1){
        imageName = @"find_hotUser_fans";
        dataTypeStr = @"用户";
        resultCountStr = [NSString stringWithFormat:@"全部%@条结果",self.viewModel.user.numFound];
    }else{
        imageName = @"albumInfoCell_tracks_mark";
        dataTypeStr = @"声音";
        resultCountStr = [NSString stringWithFormat:@"全部%@条结果",self.viewModel.track.numFound];
    }
    [sectionHeaderView.resultCountButton setTitle:resultCountStr forState:UIControlStateNormal];
    [sectionHeaderView.dataTypeButton setTitle:dataTypeStr forState:UIControlStateNormal];
    [sectionHeaderView.dataTypeButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    sectionHeaderView.changeDataButton.tag = section;
    [sectionHeaderView.changeDataButton addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
    return sectionHeaderView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.viewModel.albums.count;
    }else if (section == 1){
        return self.viewModel.users.count;
    }
    return self.viewModel.tracks.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1){
        return [tableView fd_heightForCellWithIdentifier:userID cacheByIndexPath:indexPath configuration:^(RCAllConditionUserViewCell * cell) {
            cell.doc = self.viewModel.users[indexPath.row];
        }];
    }
    return [tableView fd_heightForCellWithIdentifier:trackID cacheByIndexPath:indexPath configuration:^(RCAllConditionTrackViewCell * cell) {
        cell.doc = self.viewModel.tracks[indexPath.row];
    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    if (indexPath.section == 0) {
        RCConditionResponseDoc * doc = self.viewModel.albums[indexPath.row];

        RCAlbumDeailViewController * albumDeailVC = [[RCAlbumDeailViewController alloc]init];
        albumDeailVC.ID = doc.ID;
        [self.navigationController pushViewController:albumDeailVC animated:YES];
    }else if (indexPath.section == 1){
        RCConditionResponseDoc * doc = self.viewModel.users[indexPath.row];
        RCUserViewController * userVC = [[RCUserViewController alloc]init];
        userVC.ID = doc.uid;
        [self.navigationController  pushViewController:userVC animated:YES];

    }else{
        RCConditionResponseDoc * doc = self.viewModel.tracks[indexPath.row];

        if (doc.ID) {
            [[RCPlayerView playerView] showAnimationing:^{
                [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:doc.ID}];

            } completion:^{
            }];

        }else{

            [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"正在加载声音..."}];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [KVNProgress dismiss];
                [KVNProgress showErrorWithStatus:@"无法播放当前声音..."];
            });
            
            
        }


    }


}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}
-(NSString *)segmentTitle{

return @"所有";
}


-(UIScrollView *)streachScrollView{
    return self.tableView;
}

#pragma mark - 事件处理
- (void)changeData:(UIButton *)button{
    [RCNotificationCenter  postNotificationName:sendSelectedIndexNotification object:nil userInfo:@{sendSelectedIndexNotificationName:@(button.tag),sendConditionNotificationName:self.condition}];
//    switch (button.tag) {
//        case 0:
//
//            break;
//        case 1:
//
//            break;
//        case 2:
//
//            break;
//    }

}
@end
