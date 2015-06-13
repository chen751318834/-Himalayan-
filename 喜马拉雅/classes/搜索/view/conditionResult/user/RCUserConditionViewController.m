//
//  RCUserConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserConditionViewController.h"
#import "RCConst.h"
#import "RCUserViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCUserConditionViewCell.h"
#import "RCSearchConditionViewModel.h"
static NSString * const ID = @"cell";
@interface RCUserConditionViewController ()
@property(nonatomic,assign) NSUInteger courrentIndex;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,strong) RCSearchConditionViewModel  *viewModel;
@property(nonatomic,copy) NSString  *condition;

@end

@implementation RCUserConditionViewController
-  (RCSearchConditionViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchConditionViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
        [self.tableView registerNib:[UINib nibWithNibName:@"RCUserConditionViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [RCNotificationCenter addObserver:self selector:@selector(loadNewData:) name:LoadUserDataNotification object:nil];
}
- (void)loadNewData:(NSNotification *)note{
    [KVNProgress showWithStatus:@"正在加载..."];

    self.condition = note.userInfo[loadDataOfConditionNotificationName];
    [self.viewModel fetchNewUserWithDataType:0 condition:note.userInfo[loadDataOfConditionNotificationName] success:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter setHidden:NO];
        [KVNProgress dismiss];
    } failure:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress dismiss];
            [KVNProgress showErrorWithStatus:@"加载出错了，请稍后再试..."];
        });
    }];


}
- (void)loadMoreData{
[self.viewModel fetchMoreUserWithDataType:(int)self.courrentIndex condition:self.condition success:^{
    [self.tableView reloadData];
    [self.tableView.gifFooter endRefreshing];
} failure:^{
    [self.tableView.gifFooter endRefreshing];

} completion:^{

}];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCUserConditionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.doc = self.viewModel.responseUserDocs[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.responseUserDocs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCUserConditionViewCell * cell) {
        cell.doc = self.viewModel.responseUserDocs[indexPath.row];

    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"相关度",@"最多粉丝",@"最多声音"]];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    [segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    self.courrentIndex = segmentControl.selectedSegmentIndex;

    return segmentControl;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCConditionResponseDoc * doc = self.viewModel.responseUserDocs[indexPath.row];
    RCUserViewController * userVC = [[RCUserViewController alloc]init];
    userVC.ID = doc.uid;
    [self.navigationController  pushViewController:userVC animated:YES];
}
- (void)valueChanged:(UISegmentedControl *)control{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    self.courrentIndex = control.selectedSegmentIndex;
    [self.viewModel fetchNewUserWithDataType:(int)self.courrentIndex condition:self.condition success:^{
        [self.tableView reloadData];
    } failure:^{

    }];
    
}
-(NSString *)segmentTitle{

    return @"找人";
}


-(UIScrollView *)streachScrollView{
    return self.tableView;
}

@end
