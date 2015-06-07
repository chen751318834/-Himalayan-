//
//  RCDownloadAlbumViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDownloadAlbumViewController.h"
#import "RCDownloadTool.h"
#import "RCTrackList.h"
@interface RCDownloadAlbumViewController ()

@end

@implementation RCDownloadAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView removeHeader];
    [self.tableView removeFooter];
    [self.contents addObjectsFromArray:[RCDownloadTool downloadAlbums]];
    NSLog(@"%@",[RCDownloadTool downloadAlbums]);
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString   *ID =@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
    }
    RCTrackList * list = self.contents[indexPath.row];
    cell.textLabel.text = list.albumTitle;
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contents.count;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
