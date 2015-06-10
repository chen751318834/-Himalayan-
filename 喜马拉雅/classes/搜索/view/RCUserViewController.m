//
//  RCUserViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCSearchViewModel.h"
#import "RCSearchReslultUserViewCell.h"
static NSString * const ID = @"userCell";
@interface RCUserViewController ()
@property(nonatomic,strong) RCSearchViewModel  *viewModel;

@end

@implementation RCUserViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];
        self.viewModel.ID = self.ID;
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCSearchReslultUserViewCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadNewData];
}
- (void)loadNewData{
    [self.viewModel fetchUserInfoWithSuccess:^{

    } failure:^{

    }];
    [self.viewModel fetchUserAlbumsWithSuccess:^{

    } failure:^{

    }];
    [self.viewModel fetchUserAudiosWithSuccess:^{

    } failure:^{

    } completion:^{

    }];
}

- (void)loadMoreData{

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCSearchReslultUserViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contents.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
