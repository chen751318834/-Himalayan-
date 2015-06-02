//
//  RCPlayerAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerAlbumViewController.h"

@interface RCPlayerAlbumViewController ()
@property(nonatomic,weak) UIButton   *button;

@end

@implementation RCPlayerAlbumViewController

//- (UIButton *)button
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}
-(NSString *)segmentTitle{

    return @"相关专辑";
}


-(UIScrollView *)streachScrollView{

    return self.tableView;
}
@end
