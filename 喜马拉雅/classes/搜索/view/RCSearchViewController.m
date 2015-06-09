//
//  RCSearchViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchViewController.h"
#import "RCSearchViewCell.h"
#import "RCSearchBar.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCBottomPlayerButton.h"
#import "RCConst.h"
#import "UIImage+RC.h"
#import "SKTagView.h"
#import "HexColor.h"
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

static NSString * const ID = @"searchCell";
@interface RCSearchViewController ()
@property(nonatomic,weak) RCSearchBar   *searchBar;
@property(nonatomic,strong) NSMutableArray  *texts;
@property (nonatomic, strong) NSArray *colorPool;

@end

@implementation RCSearchViewController

-  (NSMutableArray *)texts{
    if (!_texts) {
        self.texts = [NSMutableArray array];

    }
    return _texts;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    [[RCBottomPlayerButton playingAudioButton] moveToTop];;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[RCBottomPlayerButton playingAudioButton] moveToBottom];;

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpSearchBar];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCSearchViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    for (int i = 0; i<20; i++) {
        NSString * text = [NSString stringWithFormat:@"hahah %d",i];
        [self.texts addObject:text];
    }
}

- (void)setUpSearchBar{
    RCSearchBar * searchBar = [RCSearchBar searchBar];
    searchBar.frame = CGRectMake(10, 40, self.view.bounds.size.width - 40, 29);
    searchBar.textColor = [UIColor blackColor];
    [searchBar setBackground:[UIImage imageNamed:@"find_searchbar"]];

    self.navigationItem.titleView = searchBar;
    [[searchBar rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(RCSearchBar * seachBar) {
        [searchBar setBackground:[UIImage imageNamed:@"netsound_search"]];
    }];
    [[searchBar rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(RCSearchBar * seachBar) {
        [seachBar setBackground:[UIImage imageNamed:@"find_searchbar"]];
    }];
    self.searchBar = searchBar;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)configureCell:(RCSearchViewCell *)cell atIndexPath:(NSIndexPath *)indexPath  texts:(NSArray *)texts
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(5, 5, 5, 5);
    cell.tagView.insets    = 5;
    cell.tagView.lineSpace = 5;

    [cell.tagView removeAllTags];
    cell.tagView.didClickTagAtIndex = ^(NSUInteger index){
     };
    //Add Tags
    [texts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [cell.tagView addTag:[self tagWithIndex:idx title:obj]];
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.searchHistory = YES;
    }else{
        cell.searchHistory = NO;
    }
    [self configureCell:cell atIndexPath:indexPath texts:self.texts];

    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCSearchViewCell *cell = nil;
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }

    [self configureCell:cell atIndexPath:indexPath texts:self.texts];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - User interactions
- (void)handleBtn:(id)sender
{
    NSLog(@"Tapped me");
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark - praive
- (SKTag *)tagWithIndex:(NSUInteger)index title:(NSString *)title{

    SKTag *tag = [SKTag tagWithText:title];
    tag.textColor = [UIColor whiteColor];
    tag.fontSize = 12;
    tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    tag.bgImg = [UIImage imageWithColor:[UIColor colorWithHexString:self.colorPool[index % self.colorPool.count]]];
    tag.cornerRadius = 5;
    return tag;
}
- (void)addTagWithTitle:(NSString *)title{
       RCSearchViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    [cell.tagView addTag:[self tagWithIndex:0 title:title]];
    [self.texts addObject:title];
    [self.tableView reloadData];

}
@end
