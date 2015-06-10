//
//  RCSearchResultViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchResultViewController.h"
#import "RCSearchBar.h"
#import "RCSegementControl.h"
#import "RCAlbumDeailViewController.h"
#import "RCConst.h"
#import "RCPlayerView.h"
#import "RCUserViewController.h"
#import "RCSearchViewModel.h"
#import "RCSearchResultList.h"
@interface RCSearchResultViewController ()
@property(nonatomic,weak) RCSearchBar   *searchBar;
@property(nonatomic,assign) NSUInteger currentIndex;
@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@end

@implementation RCSearchResultViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCSearchViewModel alloc]init];

    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpheaderView];
}
- (void)setUpheaderView{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"全部",@"找专辑",@"找人",@"找声音"]];
    segmentControl.selectedSegmentIndex = self.currentIndex;
    segmentControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    [segmentControl addTarget:self action:@selector(changedValue:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = segmentControl;

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"resultCell" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    RCSearchResultList * result = self.searchResult[indexPath.row];
    cell.textLabel.text = result.title;
    NSString * imageName = nil;
    switch (self.resultDataType) {
        case RCSearchViewModelDataTypeAll:
//            imageName = @"checkmark_n";
            break;
        case RCSearchViewModelDataTypeAlbum:
            imageName = @"scopeAlbum_icon";

            break;
        case RCSearchViewModelDataTypeuser:
            imageName = @"find_hotUser_fans";

            break;
        case RCSearchViewModelDataTypeAudio:
            imageName = @"albumInfoCell_tracks_mark";

            break;
        default:
            break;
    }
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.searchResult.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCSearchResultList * result = self.searchResult[indexPath.row];
    if (self.resultDataType == RCSearchViewModelDataTypeAll) {

    }else if (self.resultDataType == RCSearchViewModelDataTypeAlbum){
        RCAlbumDeailViewController * albumVc = [[RCAlbumDeailViewController alloc]init];
        albumVc.ID = result.ID;
        [self.navigationController pushViewController:albumVc animated:YES];

    }else if (self.resultDataType == RCSearchViewModelDataTypeuser){

        RCUserViewController * userVC = [[RCUserViewController alloc]init];
        [self.navigationController pushViewController:userVC animated:YES];

    }else{
        [self.view resignFirstResponder];
        [[RCPlayerView playerView] showAnimationing:^{
            [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:result.ID}];

        } completion:^{

        }];

    }

}
#pragma mark - 事件处理
- (void)changedValue:(UISegmentedControl *)control{
    self.currentIndex = control.selectedSegmentIndex;
    [RCNotificationCenter postNotificationName:searchDataTypeNotification object:nil userInfo:@{searchDataTypeNotificationName:@(self.currentIndex)}];

}
@end
