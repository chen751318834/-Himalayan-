//
//  RCUserConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserConditionViewController.h"

@interface RCUserConditionViewController ()

@end

@implementation RCUserConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
}


-(NSString *)segmentTitle{

    return @"找人";
}


-(UIScrollView *)streachScrollView{
    return self.tableView;
}

@end
