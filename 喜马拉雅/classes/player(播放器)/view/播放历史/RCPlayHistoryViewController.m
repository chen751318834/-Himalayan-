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
}

- (void)loadNewData{
    [self.lists addObjectsFromArray:[RCPlayerTool playedAudiosWithPage:0]];
    [self.tableView reloadData];
    [self.tableView.gifHeader endRefreshing];

}

- (void)loadMoreData{
    self.page ++;
    [self.lists addObjectsFromArray:[RCPlayerTool playedAudiosWithPage:self.page]];
    [self.tableView reloadData];
    [self.tableView.gifFooter endRefreshing];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    RCPlayerInfo *  info = self.lists[indexPath.row];
    cell.textLabel.text =  info.title;
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lists.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
