//
//  RCAlbumConditionViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumConditionViewController.h"

@interface RCAlbumConditionViewController ()

@end

@implementation RCAlbumConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
}

-(NSString *)segmentTitle{

    return @"找专辑";
}


-(UIScrollView *)streachScrollView{
    return self.tableView;
}

@end
