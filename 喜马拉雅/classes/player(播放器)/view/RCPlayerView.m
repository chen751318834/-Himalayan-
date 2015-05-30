//
//  RCPlayerView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerView.h"
#import "RCPlayerCommentViewCell.h"
#import "RCConst.h"
#import "CSStickyHeaderFlowLayout.h"
#import "RCPlayerHeaderViewCell.h"
#import "RCContentViewCell.h"
@interface RCPlayerView () <UITableViewDelegate,UITableViewDataSource,RCPlayerHeaderViewCellDelegate,RCContentViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,assign) NSUInteger courrentIndex;
@property(nonatomic,weak) RCContentViewCell   *contentCell;

@end
@implementation RCPlayerView
+ (instancetype)playerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCPlayerView" owner:nil options:nil] lastObject];

}
- (void)awakeFromNib{

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RCPlayerHeaderViewCell * cell = [RCPlayerHeaderViewCell cell];
        cell.delegate = self;
        return cell;
    }
    RCContentViewCell * cell = [RCContentViewCell cell];
    self.contentCell = cell;
    cell.delegate = self;
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 520;
    }
    return self.bounds.size.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section ==  1) {
        return 44;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"评价",@"详情",@"相关专辑"]];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
      self.segmentControl = segmentControl;
    [segmentControl addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventValueChanged];

    return segmentControl;

}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)changeData:(UISegmentedControl *)control{
    [RCNotificationCenter postNotificationName:selectedSegmentControlIndexNotification object:nil userInfo:@{selectedSegmentControlIndexNotificationName:@(control.selectedSegmentIndex)}];

}
- (void)back:(RCPlayerHeaderViewCell *)headerViewCell{
    [RCNotificationCenter postNotificationName:backHomeNotification object:nil];
}- (void)didScroll:(RCContentViewCell *)contentCell offfset:(CGPoint)offset{
    int page = (int)( offset.x /self.bounds.size.width+0.5);
    [UIView animateWithDuration:0.25 animations:^{
        self.segmentControl.selectedSegmentIndex = page;
    }];
}
@end
