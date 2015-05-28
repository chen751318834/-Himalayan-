//
//  RCAlbumDownLoadViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDownLoadViewController.h"
#import "RCTrackList.h"
#import "RCAlbumDownLoadSectionHeaderView.h"
#import "RCAlbumDownloadViewCell.h"
#import "UIView+AutoLayout.h"
#import "RCTitleButton.h"
#import "RCAlbumDownloadBottomToolBar.h"
#import "UIBarButtonItem+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RCAlbumDownLoadViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak) UIButton   *coverButton;
@property(nonatomic,weak) UITableView   *tableView;
@property(nonatomic,weak) RCAlbumDownloadBottomToolBar   *bottomToolBar;


@end

@implementation RCAlbumDownLoadViewController
-  (UIButton *)coverButton{
    if (!_coverButton) {
        UIButton * coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        coverButton.backgroundColor = [UIColor blackColor];
        coverButton.alpha = 0.4;
        self.coverButton = coverButton;
        [self.view addSubview:self.coverButton];
        [self.coverButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];


    }
    return _coverButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    self.coverButton.hidden = YES;
    self.title = @"批量下载";
    self.tableView.allowsSelection = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"正在下载" style:UIBarButtonItemStylePlain target:self action:@selector(enterDownloadingVC)];
    [self setUpToolbar];


}
- (void)setUpToolbar{
    RCAlbumDownLoadSectionHeaderView * topToolBar = [RCAlbumDownLoadSectionHeaderView sectionHeaderView];
    topToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topToolBar];
    [topToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)excludingEdge:ALEdgeBottom];
    [topToolBar autoSetDimension:ALDimensionHeight toSize:44];

    RCAlbumDownloadBottomToolBar * bottomToolBar = [RCAlbumDownloadBottomToolBar toolbar];
    self.bottomToolBar = bottomToolBar;
    bottomToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomToolBar];
    [bottomToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)excludingEdge:ALEdgeTop];
    [bottomToolBar autoSetDimension:ALDimensionHeight toSize:44];
    [[bottomToolBar.nowDownloaduButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
      //下载
    }];

    [[bottomToolBar.seleectedAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
        button.selected = !button.isSelected;
        NSUInteger selectedCount = 0;
            for (RCTrackList * list in self.tracklist) {
             list.check = button.isSelected;
                if (list.isCheck) {
                    bottomToolBar.nowDownloaduButton.enabled = YES;
                    selectedCount ++;
                }else{
                    bottomToolBar.nowDownloaduButton.enabled = NO;
                }
            }

        if (selectedCount) {
            [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载(%ld)",selectedCount] forState:UIControlStateNormal];
        }else{
            [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载"] forState:UIControlStateNormal];
        }
        [self.tableView reloadData];


    }];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumDownloadViewCell  *  cell = [RCAlbumDownloadViewCell cell];
    RCTrackList * list = self.tracklist[indexPath.row];
    cell.list = list;
    [[cell.selectedButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
        list.check = !list.isCheck;
        BOOL nowDownloadButtonEnable = NO;
        NSUInteger selectedCount = 0;
        for (RCTrackList * list in self.tracklist) {
            if (list.isCheck) {
                selectedCount ++;
                nowDownloadButtonEnable = YES;
            }
            self.bottomToolBar.nowDownloaduButton.enabled = nowDownloadButtonEnable;
            if (selectedCount) {
                [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载(%ld)",selectedCount] forState:UIControlStateNormal];

            }else{
                [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载"] forState:UIControlStateNormal];

            }
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tracklist.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 30;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //    return headerView;
//}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 事件处理
- (void)enterDownloadingVC{


}
@end
