//
//  RCAlbumConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumConditionViewController.h"
#import "RCAlbumDeailViewController.h"
#import "RCConst.h"
#import "RCAlbumConditionViewCell.h"
#import "RCSearchConditionViewModel.h"
static NSString * const ID = @"cell";
@interface RCAlbumConditionViewController ()
@property(nonatomic,assign) NSUInteger courrentIndex;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,strong) RCSearchConditionViewModel  *viewModel;

@end

@implementation RCAlbumConditionViewController
-  (RCSearchConditionViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchConditionViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
    [self .tableView registerNib:[UINib nibWithNibName:@"RCAlbumConditionViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.gifFooter.hidden = NO;
    [RCNotificationCenter addObserver:self selector:@selector(loadNewData:) name:loadAlbumDataNotification object:nil];
//    [self.viewModel fetchNewAlbumWithDataType:0 condition:self.condition  success:^{
//        [self.tableView reloadData];
//    } failure:^{
//
//    }];

}
- (void)loadNewData:(NSNotification *)note{
    [self.viewModel.responseDocs removeAllObjects];
    [self.tableView reloadData];
    NSLog(@"%@",note.userInfo[loadDataOfConditionNotificationName]);
    self.condition = note.userInfo[loadDataOfConditionNotificationName];
    [self.viewModel fetchNewAlbumWithDataType:0 condition:note.userInfo[loadDataOfConditionNotificationName]  success:^{
        [self.tableView reloadData];
    } failure:^{

    }];
}
- (void)loadMoreData{
    [self.viewModel fetchMoreAlbumWithDataType:(int)self.courrentIndex condition:self.condition success:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];
    } completion:^{

    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCAlbumConditionViewCell * cell =[tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.doc = self.viewModel.responseDocs[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.responseDocs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCConditionResponseDoc * doc = self.viewModel.responseDocs[indexPath.row];
    RCAlbumDeailViewController * albumDeailVC = [[RCAlbumDeailViewController alloc]init];
    albumDeailVC.ID = doc.ID;
    [self.navigationController pushViewController:albumDeailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"相关度",@"最新上传",@"最多播放"]];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    [segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    return segmentControl;
}
- (void)valueChanged:(UISegmentedControl *)control{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    self.courrentIndex = control.selectedSegmentIndex;
    [self.viewModel fetchNewAlbumWithDataType:(int)self.courrentIndex condition:self.condition  success:^{
        [self.tableView reloadData];
    } failure:^{

    }];

}
-(NSString *)segmentTitle{

    return @"找专辑";
}

-(UIScrollView *)streachScrollView{
    return self.tableView;
}

@end
