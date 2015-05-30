//
//  RCAttentionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAttentionViewController.h"
#import "RCAttentionViewModel.h"
#import "RCAttentionViewCell.h"
#import "RCAtentionTopViewCell.h"
@interface RCAttentionViewController ()
@property(nonatomic,strong) RCAttentionViewModel  *viewModel;

@end

@implementation RCAttentionViewController
-  (RCAttentionViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCAttentionViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.941 green:0.969 blue:1.000 alpha:1.000];
    [self.tableView removeHeader];
    [self.tableView removeFooter];
    [self.viewModel fetchAttentionDataWithSuccess:^{
        [self.tableView reloadData];

    } failure:^{
    
    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RCAtentionTopViewCell * cell = [RCAtentionTopViewCell cell];
        cell.data = [self.viewModel dataAtIndexPath:indexPath];
        return cell;
    }
    RCAttentionViewCell * cell = [RCAttentionViewCell cell];
    cell.data = [self.viewModel frDataAtIndexPath:indexPath];
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }

    return 113;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowInSection:section];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
