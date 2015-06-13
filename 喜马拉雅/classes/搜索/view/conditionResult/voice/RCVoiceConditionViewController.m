//
//  RCVoiceConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCVoiceConditionViewController.h"
#import "RCConst.h"
#import "RCSearchConditionViewModel.h"
#import "RCVoiceConditionViewCell.h"
#import "RCPlayerView.h"
static NSString * const ID = @"cell";
@interface RCVoiceConditionViewController ()
@property(nonatomic,assign) NSUInteger courrentIndex;
@property(nonatomic,weak) UISegmentedControl   *segmentControl;
@property(nonatomic,strong) RCSearchConditionViewModel  *viewModel;
@property(nonatomic,copy) NSString  *condition;

@end

@implementation RCVoiceConditionViewController
-  (RCSearchConditionViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchConditionViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCVoiceConditionViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [RCNotificationCenter addObserver:self selector:@selector(loadNewData:) name:loadVoiceDataNotification object:nil];
}
- (void)loadNewData:(NSNotification *)note{
    self.condition = note.userInfo[loadDataOfConditionNotificationName];
    [self.viewModel fetchNewVoiceWithDataType:0 condition:note.userInfo[loadDataOfConditionNotificationName] success:^{
        [self.tableView reloadData];
    } failure:^{

    }];


}
- (void)loadMoreData{
    [self.viewModel fetchMoreVoiceWithDataType:(int)self.courrentIndex condition:self.condition success:^{
        [self.tableView reloadData];
        [self.tableView.gifFooter endRefreshing];
    } failure:^{
        [self.tableView.gifFooter endRefreshing];
    } completion:^{

    }];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCVoiceConditionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.doc = self.viewModel.responseVoiceDocs[indexPath.row];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.viewModel.responseVoiceDocs.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    RCConditionResponseDoc * doc = self.viewModel.responseVoiceDocs[indexPath.row];
    if (doc.ID) {
        [[RCPlayerView playerView] showAnimationing:^{
            [RCNotificationCenter postNotificationName:sendNetWorkingNotification object:nil userInfo:@{netWorkingTrackIdNotificationName:doc.ID}];

        } completion:^{
        }];

    }else{

        [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"正在加载声音..."}];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress dismiss];
            [KVNProgress showErrorWithStatus:@"无法播放当前声音..."];
        });


    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"相关度",@"最新上传",@"最多播放"]];
    segmentControl.selectedSegmentIndex = self.courrentIndex;
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    self.courrentIndex = segmentControl.selectedSegmentIndex;
    [segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    return segmentControl;
}
- (void)valueChanged:(UISegmentedControl *)control{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

    self.courrentIndex = control.selectedSegmentIndex;
    [self.viewModel fetchNewVoiceWithDataType:(int)self.courrentIndex condition:self.condition success:^{
        [self.tableView reloadData];
    } failure:^{

    }];
    
}
-(NSString *)segmentTitle{

    return @"找声音";
}


-(UIScrollView *)streachScrollView{
    return self.tableView;
}
@end
