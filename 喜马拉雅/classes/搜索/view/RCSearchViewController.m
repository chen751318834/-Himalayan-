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
#import "RCSubjectList.h"
#import "RCConst.h"
#import "RCSearchViewModel.h"
#import "UIImage+RC.h"
#import "SKTagView.h"
#import "RCSearchResultViewController.h"
#import "HexColor.h"
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

static NSString * const ID = @"searchCell";
@interface RCSearchViewController () <UISearchBarDelegate>
@property(nonatomic,weak) UISearchBar   *searchBar;
@property(nonatomic,strong) NSMutableArray  *texts;
@property (nonatomic, strong) NSArray *colorPool;
@property(nonatomic,strong) RCSearchResultViewController   *resultVC;
@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@property(nonatomic,assign) int currentIndex;

@end

@implementation RCSearchViewController
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];

    }
    return _viewModel;
}
-  (RCSearchResultViewController *)resultVC{
    if (!_resultVC) {
        RCSearchResultViewController * resultVC = [[RCSearchResultViewController alloc]init];
        resultVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
        [self addChildViewController:resultVC];
        self.resultVC = resultVC;
    }
    return _resultVC;
}

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
    [RCNotificationCenter addObserver:self selector:@selector(selectedDataType:) name:searchDataTypeNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(keyBoardEnd) name:UIKeyboardDidHideNotification object:nil];
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    for (int i = 0; i<20; i++) {
        NSString * text = [NSString stringWithFormat:@"hahah %d",i];
        [self.texts addObject:text];
    }}

- (void)setUpSearchBar{
    UISearchBar * searchBar = [[UISearchBar alloc]init];
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索声音、专辑、人                                      ";
    [searchBar setBackgroundImage:[UIImage imageNamed:@"sound_act"]];
    searchBar.frame = CGRectMake(10, 40, self.view.bounds.size.width - 40, 29);
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;

}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [self.view addSubview:self.resultVC.view];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.resultVC.view removeFromSuperview];

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length != 0) {
        [self.viewModel fetchhotSearchDataWithIndex:self.currentIndex keywords:searchText success:^{
            self.resultVC.searchResult = self.viewModel.models;
            [self.resultVC.tableView reloadData];
        } failure:^{

        }];
    }
    NSLog(@"%d",self.currentIndex);

}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField setBackground:[UIImage imageNamed:@"netsound_search"]];
    [self.view addSubview:self.resultVC.view];



}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField setBackground:[UIImage imageNamed:@"find_searchbar"]];
    [self.resultVC.view removeFromSuperview];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)configureCell:(RCSearchViewCell *)cell atIndexPath:(NSIndexPath *)indexPath  texts:(NSArray *)texts
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(10, 10, 10, 10);
    cell.tagView.insets    = 15;
    cell.tagView.lineSpace = 10;

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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar setText:nil];
    [self.searchBar resignFirstResponder];
    /**
     *  去除SectionheaderView的站粘性
     */
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 30; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y+70, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight-20, 0, 0, 0);
        }

    }
}
#pragma mark - praive
- (void)keyBoardEnd{
    self.viewModel.models = nil;
    self.resultVC.searchResult = nil;
    [self.resultVC.tableView reloadData];

}
- (void)selectedDataType:(NSNotification *)note{

    int index = [note.userInfo[searchDataTypeNotificationName] intValue];
    self.currentIndex = index;
    [self .viewModel fetchhotSearchDataWithIndex:index keywords:self.searchBar.text success:^{
        self.resultVC.searchResult = self.viewModel.models;
        [self.resultVC.tableView reloadData];
    } failure:^{

    }];
}
- (SKTag *)tagWithIndex:(NSUInteger)index title:(NSString *)title{

    SKTag *tag = [SKTag tagWithText:title];
    tag.textColor = [UIColor grayColor];
    tag.fontSize = 13;
    tag.padding = UIEdgeInsetsMake(7, 7, 7, 7);
    tag.bgImg = [UIImage imageNamed:@"sound_act"];
    tag.cornerRadius = 10;
    return tag;
}
- (void)addTagWithTitle:(NSString *)title{
       RCSearchViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:ID];

    [cell.tagView addTag:[self tagWithIndex:0 title:title]];
    [self.texts addObject:title];
    [self.tableView reloadData];

}
@end
