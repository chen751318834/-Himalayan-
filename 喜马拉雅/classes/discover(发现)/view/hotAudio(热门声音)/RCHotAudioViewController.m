//
//  RCHotAudioViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioViewController.h"
#import "RCHotAudioVIewModel.h"
#import "RCConst.h"
@interface RCHotAudioViewController ()
@property(nonatomic,strong) RCHotAudioVIewModel  *viewModel;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;

@end

@implementation RCHotAudioViewController
-  (RCHotAudioVIewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCHotAudioVIewModel alloc]init];

    }
    return _viewModel;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门声音";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.contents = self.viewModel.models;
    [self setUpSectionHeaderView];
}
- (void)setUpSectionHeaderView{





}
#pragma mark - 网络请求
- (void)loadNewData{

    [self.viewModel fetchNewHotAudioDataWithSuccess:^{

        [self.tableView reloadData];
        [self.tableView.gifHeader endRefreshing];
    } failure:^{
        [self.tableView.gifHeader endRefreshing];

    }];
}
- (void)loadMoreData{

    [self.viewModel fetchMoreHotAudioDataWithSuccess:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];

    } failure:^{
        [self.tableView.gifFooter endRefreshing];
        
    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"hotAudioCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    cell.textLabel.text = @"ddaaaa";
    return cell;


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"最火",@"本周最热",@"最多赞"]];
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:0.983 green:0.000 blue:0.257 alpha:1.000];
    [[segmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl * segmentControl) {
        switch (segmentControl.selectedSegmentIndex) {
            case 0:
                RCLog(@"changeData---1");
                break;
            case 1:
                RCLog(@"changeData---2");

                break;
            case 2:
                RCLog(@"changeData---3");

                break;
            default:
                break;
        }
        
    }];
    return segmentControl;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 事件处理
@end
