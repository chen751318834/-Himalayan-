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
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCAllConditionSectionheaderView.h"
#import "RCAllConditionUserViewCell.h"
#import "RCAllConditionAlbumViewCell.h"
#import "RCAllConditionTrackViewCell.h"
static NSString * const albumID = @"albumID";
static NSString * const userID = @"userID";
static NSString * const trackID = @"trackID";
@interface RCAllConditionViewController ()
@property(nonatomic,strong) RCSearchConditionViewModel  *viewModel;
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
    NSLog(@"%@",note.userInfo[sendSearchConditionNotificationName]);
    [self.viewModel fetchNewAllWithCondition:note.userInfo[sendSearchConditionNotificationName] success:^{
        [self.tableView reloadData];

    } failure:^{
        [KVNProgress showError];
    }];


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

    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [RCAllConditionSectionheaderView sectionHeaderView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.viewModel.albums.count;
    }else if (section == 1){
        return self.viewModel.users.count;
    }
    return self.viewModel.tracks.count;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:albumID cacheByIndexPath:indexPath configuration:^(RCAllConditionAlbumViewCell * cell) {
            cell.doc = self.viewModel.albums[indexPath.row];

        }];

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


@end
