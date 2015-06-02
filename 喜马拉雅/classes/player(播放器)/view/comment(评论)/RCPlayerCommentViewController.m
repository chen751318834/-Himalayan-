//
//  RCPlayerCommentViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerCommentViewController.h"

@interface RCPlayerCommentViewController ()

@end

@implementation RCPlayerCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    cell.textLabel.text = @"commment";
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 30;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(NSString *)segmentTitle{

return @"评论";
}


-(UIScrollView *)streachScrollView{

    return self.tableView;
}
@end
