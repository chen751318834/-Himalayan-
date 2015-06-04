//
//  RCPlayerDeialViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerDeialViewController.h"
#import "RCPlayerVIewModel.h"
#import "RCPlayerDeialViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCConst.h"
static NSString * const ID = @"playerDeailCell";

@interface RCPlayerDeialViewController ()
@property(nonatomic,strong) RCPlayerVIewModel  *viewmodel;

@end

@implementation RCPlayerDeialViewController
-  (RCPlayerVIewModel *)viewmodel{
    if (!_viewmodel) {
        self.viewmodel = [[RCPlayerVIewModel alloc]init];
        self.viewmodel.trackId = self.trackId;
    }
    return _viewmodel;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"RCPlayerDeialViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.viewmodel fetchPlayerTrackDeailWithSuccess:^{
        [self.tableView reloadData];
    } failure:^{

    }];


}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCPlayerDeialViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.deail = self.viewmodel.deails[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewmodel.deails.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCPlayerDeialViewCell * cell) {
        cell.deail = self.viewmodel.deails[indexPath.row];

    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}
- (void)dealloc{

    [RCNotificationCenter removeObserver:self];
}
-(NSString *)segmentTitle{

    return @"详情";
}


-(UIScrollView *)streachScrollView{

    return self.tableView;
}
@end
