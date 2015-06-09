//
//  RCSearchResultViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchResultViewController.h"
#import "RCSearchBar.h"
#import "RCSegementControl.h"
#import "RCSearchViewModel.h"
@interface RCSearchResultViewController ()
@property(nonatomic,weak) RCSearchBar   *searchBar;
@property(nonatomic,assign) NSUInteger currentIndex;
@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@end

@implementation RCSearchResultViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCSearchViewModel alloc]init];

    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpheaderView];
}
- (void)setUpheaderView{
    UISegmentedControl * segmentControl =[[UISegmentedControl alloc]initWithItems:@[@"全部",@"找专辑",@"找人",@"找声音"]];
    segmentControl.selectedSegmentIndex = self.currentIndex;
    segmentControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.tintColor = [UIColor colorWithRed:1.000 green:0.270 blue:0.000 alpha:1.000];
    [segmentControl addTarget:self action:@selector(changedValue:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = segmentControl;

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - 事件处理
- (void)changedValue:(UISegmentedControl *)control{
    self.currentIndex = control.selectedSegmentIndex;


}
@end
