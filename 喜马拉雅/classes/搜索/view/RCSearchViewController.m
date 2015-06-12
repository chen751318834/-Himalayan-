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
#import "ReactiveCocoa.h"
#import "RCBottomPlayerButton.h"
#import "RCSubjectList.h"
#import "RCConst.h"
#import "RCSearchViewModel.h"
#import "UIImage+RC.h"
#import "RCSearchResultDeailViewController.h"
#import "RCSearchTool.h"
#import "SKTagView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "RCSearchResultViewController.h"
#import "HexColor.h"
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

static NSString * const ID = @"searchCell";
@interface RCSearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) UISearchBar   *searchBar;
@property (nonatomic, strong) NSArray *colorPool;
@property(nonatomic,strong) RCSearchResultViewController   *resultVC;
@property(nonatomic,strong) RCSearchResultDeailViewController   *resultDeailVC;
@property(nonatomic,weak) UITableView   *tableView;

@property(nonatomic,strong) RCSearchViewModel  *viewModel;
@property(nonatomic,assign) int currentIndex;
@property(nonatomic,strong) NSMutableArray  *historySearchTexts;
@end

@implementation RCSearchViewController
#pragma mark - 懒加载

-  (NSMutableArray *)historySearchTexts{
    if (!_historySearchTexts) {
        self.historySearchTexts = [NSMutableArray array];
    }
    return _historySearchTexts;
}
-  (RCSearchViewModel *)viewModel{
    if (!_viewModel) {
        self.viewModel = [[RCSearchViewModel alloc]init];

    }
    return _viewModel;
}
-  (RCSearchResultDeailViewController *)resultDeailVC{
    if (!_resultDeailVC) {
        RCSearchResultDeailViewController * resultDeailVC = [[RCSearchResultDeailViewController alloc]init];
        resultDeailVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height- 64);
        [self addChildViewController:resultDeailVC];
        self.resultDeailVC = resultDeailVC;
    }
    return _resultDeailVC;
}

-  (RCSearchResultViewController *)resultVC{
    if (!_resultVC) {
        RCSearchResultViewController * resultVC = [[RCSearchResultViewController alloc]init];
        resultVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height -64);
        [self addChildViewController:resultVC];
        self.resultVC = resultVC;
    }
    return _resultVC;
}


#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    self.tableView.contentInset = RCGlobalTableViewUIEdgeInsets;
        [self loadData];

    [self.tableView registerNib:[UINib nibWithNibName:@"RCSearchViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpSearchBar];
    [self setUpNotificationCenter];
    self.view.backgroundColor = RCGlobalBg;


}
-(void)setUpTableView{
    UITableView * tableView = [[UITableView alloc]init];
    [self.view insertSubview:tableView atIndex:0];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

}
-(void)loadData{

   for (RCSearchResultList * list in [RCSearchTool searchHistorys]) {
       [self.historySearchTexts addObject:list.title];
   }
   [self.viewModel fetchHotSearchWithSuccess:^{
       [self.tableView reloadData];
   } failure:^{
       
   }];

}
- (void)setUpNotificationCenter{
    [RCNotificationCenter addObserver:self selector:@selector(end) name:searchResultVCEndExitingNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(selectedDataType:) name:searchDataTypeNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(keyBoardEnd) name:UIKeyboardDidHideNotification object:nil];
    [RCNotificationCenter addObserver:self selector:@selector(reloadSearchHistoryData:) name:reloadSearchHistoryNotification object:nil];

}
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
#pragma mark - UISearchBarDelegate
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
            self.resultVC.resultDataType = self.viewModel.resultDataType;
            [self.resultVC.tableView reloadData];
        } failure:^{

        }];
    }

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.resultDeailVC.view removeFromSuperview];
}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    [cell clearSearchHistoryWithTarget:self action:@selector(clearSearchHistory)];
    if (indexPath.row == 0) {
        cell.searchHistory = YES;
        [self configureCell:cell atIndexPath:indexPath texts:self.historySearchTexts];
    }
    else{
        cell.searchHistory = NO;
        [self configureCell:cell atIndexPath:indexPath texts:self.viewModel.hotSearchTexts];
    }

    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCSearchViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (indexPath.row == 0) {
        [self configureCell:cell atIndexPath:indexPath texts:self.historySearchTexts];
        return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
        [self configureCell:cell atIndexPath:indexPath texts:self.viewModel.hotSearchTexts];
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
//    /**
//     *  去除SectionheaderView的站粘性
//     */
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 30; //sectionHeaderHeight
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y+70, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight-20, 0, 0, 0);
//        }
//
//    }
}
#pragma mark - private
- (void)configureCell:(RCSearchViewCell *)cell atIndexPath:(NSIndexPath *)indexPath  texts:(NSArray *)texts
{
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding    = UIEdgeInsetsMake(10, 10, 10, 10);
    cell.tagView.insets    = 15;
    cell.tagView.lineSpace = 10;
    [cell.tagView removeAllTags];
    cell.tagView.didClickTagAtIndex = ^(NSUInteger index){
        NSString * text = texts[index];
        [self.view addSubview:self.resultDeailVC.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [RCNotificationCenter postNotificationName:sendSearchConditionNotification object:nil userInfo:@{sendSearchConditionNotificationName:text}];

        });
    };
    [texts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [cell.tagView addTag:[self tagWithIndex:idx title:obj]];
     }];
}
- (void)clearSearchHistory{
    [self.historySearchTexts removeAllObjects];
    [RCSearchTool removeAllSearchHistory];
    [self.tableView reloadData];

}
- (void)reloadSearchHistoryData:(NSNotification *)note{
    RCSearchResultList * list = note.userInfo[reloadSearchHistoryNotificationName];
    [self.historySearchTexts insertObject:list.title atIndex:0];
    [self.tableView reloadData];
}
- (void)keyBoardEnd{
    self.viewModel.models = nil;
    self.resultVC.searchResult = nil;
    [self.resultVC.tableView reloadData];

}
- (void)end{
    self.searchBar.text = nil;
    [self.searchBar resignFirstResponder];
}
- (void)selectedDataType:(NSNotification *)note{

    int index = [note.userInfo[searchDataTypeNotificationName] intValue];
    self.currentIndex = index;
    [self .viewModel fetchhotSearchDataWithIndex:index keywords:self.searchBar.text success:^{
        self.resultVC.searchResult = self.viewModel.models;
        self.resultVC.resultDataType = self.viewModel.resultDataType;
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
    [self.tableView reloadData];

}
@end
