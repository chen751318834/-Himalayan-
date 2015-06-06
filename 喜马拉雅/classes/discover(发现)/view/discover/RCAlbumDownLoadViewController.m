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
#import "RCConst.h"
#import "RCTitleButton.h"
#import "RCBottomPlayerButton.h"
#import "RCAlbumDownloadBottomToolBar.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+MJ.h"
#import "RCSegementControl.h"
#import "RCAlbumViewModel.h"

@interface RCAlbumDownLoadViewController () <UITableViewDataSource,UITableViewDelegate,RCSegementControlDelegate>
@property(nonatomic,weak) UIButton   *coverButton;
@property(nonatomic,weak) UITableView   *tableView;
@property(nonatomic,weak) RCAlbumDownloadBottomToolBar   *bottomToolBar;
@property(nonatomic,weak) UILabel   *bottomInfolabel;
@property(nonatomic,strong) NSMutableArray  *buttons;
@property(nonatomic,weak) RCSegementControl   *segementControl;
@property(nonatomic,weak) RCAlbumDownLoadSectionHeaderView   *topToolBar;
@property(nonatomic,strong) RCAlbumViewModel  *viewModel;

@end

@implementation RCAlbumDownLoadViewController
-  (RCAlbumViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCAlbumViewModel alloc]init];
        self.viewModel.ID = self.ID;
    }
    return _viewModel;
}
-  (NSMutableArray *)buttons{
    if (!_buttons) {
         self.buttons = [NSMutableArray array];

    }
    return _buttons;
}
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

- (void)viewWillAppear:(BOOL)animated{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];


}
- (void)viewWillDisappear:(BOOL)animated{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
    for (RCTrackList * list in self.viewModel.downloadLists) {
        list.check  = NO;
    }
    [[RCBottomPlayerButton playingAudioButton] moveToTop];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[RCBottomPlayerButton playingAudioButton] moveToBottom];
    UITableView * tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc]init];
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    self.coverButton.hidden = YES;
    self.title = @"批量下载";
    self.tableView.allowsSelection = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 64, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"正在下载" style:UIBarButtonItemStylePlain target:self action:@selector(enterDownloadingVC)];
    [self setUpToolbar];


}

- (void)setUpToolbar{
    [self setUpTopToolBar];

    [self setUpBottomToolBar];

}
#pragma mark - 设置顶部的工具条
- (void)setUpTopToolBar{
    RCSegementControl * segementControl = [[ RCSegementControl alloc]init];
    segementControl.backgroundColor = [UIColor whiteColor];
    
    self.segementControl = segementControl
    ;
    segementControl.delegate = self;
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"loading..."}];

    [self.viewModel fetchAlbumDeailDataWithPage:1 success:^{
        [self.tableView reloadData];
        self.topToolBar.totalCountLabel.text =  [NSString stringWithFormat:@"共%@集",self.viewModel.totalCount];

        for (int i = 0; i<[self.viewModel.totalCount intValue]/50+1; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.font = [UIFont systemFontOfSize:11];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            if (i == [self.viewModel.totalCount intValue]/50) {
        [button setTitle:[NSString stringWithFormat:@"选集(%d~%d)",i*50+1,[self.viewModel.totalCount intValue]] forState:UIControlStateNormal];
            }else{
                [button setTitle:[NSString stringWithFormat:@"选集(%d~%d)",i*50+1,i*50+50] forState:UIControlStateNormal];
            }
            [self.buttons addObject:button];
        }
        segementControl.items = self.buttons;
        segementControl.selectedSegmentIndex = 0;
        [KVNProgress dismiss];
    } failure:^{
        [KVNProgress dismiss];

    }];

    [self.view addSubview:segementControl];
    segementControl.frame = CGRectMake(0, 62, self.view.frame.size.width, 30);

    RCAlbumDownLoadSectionHeaderView * topToolBar = [RCAlbumDownLoadSectionHeaderView sectionHeaderView];
    self.topToolBar = topToolBar;
    topToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topToolBar];
    [topToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(62, 0, 0, 0)excludingEdge:ALEdgeBottom];
    [topToolBar autoSetDimension:ALDimensionHeight toSize:44];

    [topToolBar.currentRangeButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];


}
- (void)buttonDidClicked:(UIButton *)button{

    if (button.isSelected) {
        [UIView animateWithDuration:0.25f animations:^{
            self.segementControl.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            self.segementControl.transform = CGAffineTransformMakeTranslation(0, 44);
            for (RCTrackList * list in self.viewModel.downloadLists) {
                list.check = NO;
                self.bottomToolBar.seleectedAllButton.selected = NO;
                self.bottomToolBar.nowDownloaduButton.enabled = NO;
                [self setUpBottomToolBarLabel:self.bottomInfolabel selectedCount:0 size:0];

            }

        }];
    }
    button.selected = !button.isSelected;
    [self.tableView reloadData];

}
#pragma mark - 设置底部的工具条

- (void)setUpBottomToolBar{
    RCAlbumDownloadBottomToolBar * bottomToolBar = [RCAlbumDownloadBottomToolBar toolbar];
    self.bottomToolBar = bottomToolBar;
    bottomToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomToolBar];
    [bottomToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)excludingEdge:ALEdgeTop];
    [bottomToolBar autoSetDimension:ALDimensionHeight toSize:44];
//    [[bottomToolBar.nowDownloaduButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
//        //下载
//    }];

#warning 下载音频.................
    UILabel * poperLabel = [[UILabel alloc] init];
    poperLabel.backgroundColor = [UIColor colorWithWhite:0.811 alpha:1.000];
    [self.view addSubview:poperLabel];
    poperLabel.hidden = YES;
    poperLabel.textAlignment = NSTextAlignmentCenter;
    poperLabel.font = [UIFont systemFontOfSize:11];
    poperLabel.textColor = [UIColor grayColor];
    self.bottomInfolabel = poperLabel;
    [poperLabel autoSetDimension:ALDimensionWidth toSize:self.view.bounds.size.width];
    [poperLabel autoSetDimension:ALDimensionHeight toSize:20];
    [poperLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:bottomToolBar];
    [poperLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:bottomToolBar];
    [bottomToolBar.seleectedAllButton addTarget:self action:@selector(seleectedAll:) forControlEvents:UIControlEventTouchUpInside];


}
- (void)seleectedAll:(UIButton *)button{
    [self cancleChangeERangeView];
    button.selected = !button.isSelected;
    NSUInteger selectedCount = 0;
    NSUInteger   size = 0 ;
    for (RCTrackList * list in self.viewModel.downloadLists) {
        list.check = button.isSelected;
        if (list.isCheck) {
            self.bottomToolBar.nowDownloaduButton.enabled = YES;
            selectedCount ++;
            size += [list.downloadSize intValue];
        }else{
            self.bottomToolBar.nowDownloaduButton.enabled = NO;
        }
    }
    [self setUpBottomToolBarLabel:self.bottomInfolabel selectedCount:selectedCount size:size];


}
- (void)setUpBottomToolBarLabel:(UILabel *)label selectedCount:(NSUInteger )selectedCount size:(NSUInteger)size{
    if (selectedCount) {
        [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载(%ld)",selectedCount] forState:UIControlStateNormal];
    }else{
        [self.bottomToolBar.nowDownloaduButton setTitle:[NSString stringWithFormat:@"立即下载"] forState:UIControlStateNormal];

    }
    label.hidden = selectedCount == 0;

    [self.tableView reloadData];
    label.text = [NSString stringWithFormat:@"共选了%ld条声音，占用%.2fMB",selectedCount,size/1024.0/1024.0];


}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumDownloadViewCell  *  cell = [RCAlbumDownloadViewCell cell];
    RCTrackList * list = self.viewModel.downloadLists[indexPath.row];
    cell.list = list;
    @weakify(self);
    [[cell.selectedButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self cancleChangeERangeView];

        list.check = !list.isCheck;
        BOOL nowDownloadButtonEnable = NO;
        NSUInteger selectedCount = 0;
        NSUInteger   size = 0 ;
        for (RCTrackList * list in self.viewModel.downloadLists) {
            if (list.isCheck) {
                selectedCount ++;
                size += [list.downloadSize intValue];
                nowDownloadButtonEnable = YES;
            }
            self.bottomToolBar.nowDownloaduButton.enabled = nowDownloadButtonEnable;
            [self setUpBottomToolBarLabel:self.bottomInfolabel selectedCount:selectedCount size:size];
            
            
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.downloadLists.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self cancleChangeERangeView];

}
#pragma mark - RCSegementControlDelegate
- (void)segementControl:(RCSegementControl *)segement button:(UIButton *)button from:(NSUInteger)from to:(NSUInteger)to{
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"loading..."}];
    [self.viewModel fetchAlbumDeailDataWithPage:from+1 success:^{
        [self cancleChangeERangeView];
        UIButton * currentButton = self.buttons[from];
            [self.topToolBar.currentRangeButton setTitle:currentButton.currentTitle forState:UIControlStateNormal];
        [self.tableView reloadData];
        [KVNProgress dismiss];
    } failure:^{
        [UIView animateWithDuration:0.25 animations:^{
            self.topToolBar.currentRangeButton.selected = NO;
            self.segementControl.transform = CGAffineTransformIdentity;
            
        }];
        [KVNProgress dismiss];

    }];

}
- (void)cancleChangeERangeView{

    [UIView animateWithDuration:0.25 animations:^{
        self.topToolBar.currentRangeButton.selected = NO;
        self.segementControl.transform = CGAffineTransformIdentity;

    }];
}
#pragma mark - 事件处理
- (void)enterDownloadingVC{


}
@end
