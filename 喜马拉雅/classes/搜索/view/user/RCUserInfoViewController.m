
//
//  RCUserInfoViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCUserInfoViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCUserInfoViewCell.h"
#import "UIBarButtonItem+MJ.h"
static NSString * const ID = @"userInfoCell";
@interface RCUserInfoViewController ()
@property(nonatomic,strong) NSMutableArray <RCSearchUserInfo *>  *userInfos;
@end

@implementation RCUserInfoViewController
- (NSMutableArray<RCSearchUserInfo *> *)userInfos{
    if (!_userInfos) {
         self.userInfos = [NSMutableArray array];

    }
    return _userInfos;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userInfos addObject:self.userInfo];
    self.tableView.allowsSelection = NO;;
    [self.tableView registerNib:[UINib nibWithNibName:@"RCUserInfoViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"random" highImage:@"random" target:self action:@selector(back)];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCUserInfoViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.userInfo = self.userInfos[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.userInfos.count;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(RCUserInfoViewCell * cell) {
        cell.userInfo = self.userInfos[indexPath.row];

    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
