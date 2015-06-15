//
//  RCMeViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCMeViewController.h"
#import "RCConst.h"
#import "RCSearchBar.h"
#import "RCMeSettingSectionData.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "RCMeHeaderView.h"
#import "RCMeSettingItem.h"
static NSString * const ID = @"meSettingCell";
@interface RCMeViewController ()
@property(nonatomic,strong) NSMutableArray  *datas;
@end

@implementation RCMeViewController
-  (NSMutableArray *)datas{
    if (!_datas) {
        self.datas = [NSMutableArray array];
        [self.datas addObjectsFromArray:[RCMeSettingSectionData objectArrayWithFilename:@"MeSetting.plist"]];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeaderView];
    self.navigationItem.title = @"我";
    self.tableView.backgroundColor = RCGlobalBg;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}
- (void)setUpHeaderView{
  
    RCMeHeaderView * headerView  = [RCMeHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull  NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    RCMeSettingSectionData * data = self.datas[indexPath.section];
    RCMeSettingItem * item = data.items[indexPath.row];
    cell.textLabel.text = item.itemName;
    cell.imageView.image = [UIImage imageNamed:item.itemIcon];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return self.datas.count;
}
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = RCGlobalBg;
    return view;
}
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return  20;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RCMeSettingSectionData * data = self.datas[section];
    return data.items.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
