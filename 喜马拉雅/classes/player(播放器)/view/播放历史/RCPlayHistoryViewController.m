//
//  RCPlayHistoryViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayHistoryViewController.h"
#import "RCPlayerTool.h"
#import "RCPlayerInfo.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCPlayHistoryViewCell.h"
@interface RCPlayHistoryViewController ()
@property(nonatomic,strong) NSMutableArray  * lists;
@property(nonatomic,assign) NSUInteger page;

@end

@implementation RCPlayHistoryViewController
-  (NSMutableArray *)lists{
    if (!_lists) {
    self.lists= [NSMutableArray array];
    }
    return _lists;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCPlayHistoryViewCell" bundle:nil] forCellReuseIdentifier:@"historyCell"];
}

- (void)loadNewData{
    [self.lists addObjectsFromArray:[RCPlayerTool playedAudiosWithPage:0]];
    [self.tableView reloadData];
    [self.tableView.gifHeader endRefreshing];
    [self.tableView removeHeader];


}

- (void)loadMoreData{
    self.page ++;
    [self.lists addObjectsFromArray:[RCPlayerTool playedAudiosWithPage:self.page]];
    [self.tableView reloadData];
    [self.tableView.gifFooter endRefreshing];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCPlayHistoryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    RCPlayerInfo *  info = self.lists[indexPath.row];
    cell.info = info;
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lists.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"historyCell" cacheByIndexPath:indexPath configuration:^(RCPlayHistoryViewCell * cell) {
        RCPlayerInfo *  info = self.lists[indexPath.row];
        cell.info = info;
    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
