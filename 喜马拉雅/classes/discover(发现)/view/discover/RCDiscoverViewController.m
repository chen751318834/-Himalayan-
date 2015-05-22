//
//  RCDiscoverViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCDiscoverViewController.h"
#import "RCSearchBar.h"
#import "RCRecommendAlbumViewCell.h"
#import "RCPlayListViewCell.h"
#import "RCDiscover2IMGViewCell.h"
#import "RCSubjectViewController.h"
#import "RCConst.h"
#import "UIImageView+WebCache.h"
#import "RCFocusImageViewCell.h"
#import "RCCateroryListViewController.h"
#import "RCDiscoverItemViewCell.h"
#import "RCSectionheaderView.h"
#import "RCCatrgory.h"
#import "RCCategoryListViewModel.h"
#import "RCDisCoverViewModel.h"
#import "RCLatestSpecial.h"
#import "RCLatestActivity.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MJExtension.h"
static NSString * const categoryID = @"categoryCell";
static NSString * const imgID = @"imgCell";
static NSString * const img2CellID = @"img2CellID";
//RCDiscoverItemViewCell
static NSString * const TableviewCellID = @"recommendAlbumCell";
static NSString * const itemCellID = @"RCDiscoverItemViewCell";
static const NSUInteger sectionCount = 100;
@interface RCDiscoverViewController ()  <UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak) RCSearchBar   *searchBar;
@property(nonatomic,weak) UICollectionView   *categoryCollectionView;
@property(nonatomic,weak) UICollectionView   *scrollCollectionView;
@property(nonatomic,weak) UIView   *headerView;
@property(strong,nonatomic) NSTimer * timer;
@property(nonatomic,weak) UIButton   *popButton;
@property(nonatomic,strong) RCDisCoverViewModel  *viewModel;
@property(nonatomic,strong) RCCategoryListViewModel  *categoryViewModel;
@property(nonatomic,weak) UIPageControl   *pageControl;

@end

@implementation RCDiscoverViewController
#pragma mark - 懒加载
-  (RCDisCoverViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCDisCoverViewModel alloc]init];
    }
    return _viewModel;
}
-  (RCCategoryListViewModel *)categoryViewModel{
    if (!_categoryViewModel) {
        self.categoryViewModel = [[RCCategoryListViewModel alloc]init];
    }
    return _categoryViewModel;
}
#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];


}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCDiscoverItemViewCell" bundle:nil] forCellReuseIdentifier:itemCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"RCRecommendAlbumViewCell" bundle:nil] forCellReuseIdentifier:TableviewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RCDiscover2IMGViewCell" bundle:nil] forCellReuseIdentifier:img2CellID];

    [self setUpSearchBar];
    [self setUpHeaderView];
    [self setUpPageControl];

    [self.viewModel fetchDiscoverDataWithSuccess:^{
        [self.scrollCollectionView reloadData];
        [self.tableView reloadData];
        [self addTimer];

    } failure:^{

    }];

}
- (void)setUpPageControl{

    UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.userInteractionEnabled = NO;
    [self.headerView addSubview:pageControl];
    [pageControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [pageControl autoSetDimension:ALDimensionHeight toSize:20];

    self.pageControl = pageControl;


}
- (void)setUpSearchBar{
    RCSearchBar * searchBar = [RCSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 5, self.view.bounds.size.width, 29);
    self.navigationItem.titleView = searchBar;
    [[searchBar rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(RCSearchBar * searchBar) {
        [searchBar setBackground:[UIImage imageNamed:@"netsound_search"]];
    }];
    [[searchBar rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(RCSearchBar * searchBar) {
        [searchBar setBackground:[UIImage imageNamed:@"find_searchbar"]];

    }];
    self.searchBar = searchBar;
}

- (void)setUpHeaderView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat margin = 7;
    NSUInteger counlmCount = 5;
    CGFloat itemWidth = (self.view.frame.size.width - (margin *(counlmCount +1)))/counlmCount;
    layout.itemSize = CGSizeMake(itemWidth, 70);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 7;
    UICollectionView * categoryCollectionView = [self setUpConllectionViewWithLayout:layout];
    categoryCollectionView.scrollEnabled = NO;
    [categoryCollectionView registerClass:[RCPlayListViewCell class] forCellWithReuseIdentifier:categoryID];
    self.categoryCollectionView = categoryCollectionView;
    UIButton * popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    popButton.imageView.contentMode = UIViewContentModeCenter;
    [popButton setImage:[UIImage imageNamed:@"findCategory_arrow_down"] forState:UIControlStateNormal];
    [categoryCollectionView addSubview:popButton];
    popButton.backgroundColor = [UIColor whiteColor];
    [popButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.view.bounds.size.width- itemWidth relation:NSLayoutRelationEqual];
    [popButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:75];
    [popButton autoSetDimension:ALDimensionWidth toSize:itemWidth];
    [popButton autoSetDimension:ALDimensionHeight toSize:72];
    self.popButton = popButton;


    UICollectionViewFlowLayout * scrollLayout = [[UICollectionViewFlowLayout alloc]init];
    scrollLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 170);
    scrollLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    scrollLayout.minimumLineSpacing = 0;
    scrollLayout.minimumInteritemSpacing = 0;
    UICollectionView * scrollCollectionView =  [self setUpConllectionViewWithLayout:scrollLayout];

    self.scrollCollectionView = scrollCollectionView;
    [self.scrollCollectionView registerClass:[RCFocusImageViewCell class] forCellWithReuseIdentifier:imgID];
    scrollCollectionView.pagingEnabled = YES;
    scrollCollectionView.showsHorizontalScrollIndicator = NO;
    UIView * headerView = [[UIView alloc]init];
    [headerView addSubview:self.categoryCollectionView];
    [headerView addSubview:self.scrollCollectionView];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 324);
    self.headerView = headerView;
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;

    [categoryCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [categoryCollectionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:scrollCollectionView withOffset:0];
    [scrollCollectionView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headerView withOffset:0];
    [scrollCollectionView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:headerView withOffset:0];
    [scrollCollectionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:headerView];
    [scrollCollectionView autoSetDimension:ALDimensionHeight toSize:170];
    self.tableView.tableHeaderView.height = 324;
    @weakify(self);
    [[popButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * button) {
        @strongify(self);
        CGRect newFrame = headerView.frame;
        newFrame.size.height = 570;
        headerView.frame = newFrame;
        [self.tableView beginUpdates];
        [self.tableView setTableHeaderView:headerView];
        [self.tableView endUpdates];
        button.hidden = YES;

    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == self.scrollCollectionView) {
        return sectionCount;
    }else{
        return [self.viewModel numberOfSectionsInCollectionView];
    }

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.categoryCollectionView) {
        return [self.viewModel numberOfItemInSectionInCategoryCollectionView:section];
    }
    self.pageControl.numberOfPages = [self.viewModel numberOfItemInSectionInImgCollectionView:section];
    return [self.viewModel numberOfItemInSectionInImgCollectionView:section];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.categoryCollectionView) {
        RCPlayListViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryID forIndexPath:indexPath];
        cell.caterory = [self.viewModel categoryAtIndexPathInCollectionView:indexPath];
        return cell;
    }
    RCFocusImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgID forIndexPath:indexPath];
    cell.list = [self.viewModel imgAtIndexPathInCollectionView:indexPath];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.categoryCollectionView) {
        if (indexPath.item == [self.viewModel numberOfItemInSectionInCategoryCollectionView:indexPath.section] - 1) {
            CGRect newFrame = self.headerView.frame;
            newFrame.size.height = 324;
            self.headerView.frame = newFrame;
            [self.tableView beginUpdates];
            [self.tableView setTableHeaderView:self.headerView];
            [self.tableView endUpdates];
            self.popButton.hidden = NO;

        }else{
            RCCatrgory * catrgory = [self.viewModel categoryAtIndexPathInCollectionView:indexPath];
            RCCateroryListViewController * categoryListVC = [[RCCateroryListViewController alloc]init];
            categoryListVC.category = catrgory;
            [self.navigationController pushViewController:categoryListVC animated:YES];
            
        }
        

    }
    }

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
    [self.searchBar endEditing:YES];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self addTimer];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self resetedIndexPath];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollCollectionView) {
        int currentPage = (int)(scrollView.contentOffset.x /scrollView.bounds.size.width+0.5)%[self.viewModel numberOfItemInSectionInImgCollectionView:0];
        __weak typeof(self) weakSelf  = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.pageControl.currentPage = currentPage;

        }];
    }
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
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSectionsInTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfItemInSectionInTableView:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self.viewModel cellHeihtWithIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        RCDiscover2IMGViewCell * cell = [tableView dequeueReusableCellWithIdentifier:img2CellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        RCDiscoverItemViewCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCellID forIndexPath:indexPath];
        [cell.iconView setImage:[UIImage imageNamed:@"findcell_srlogo"]];
        cell.titleLabel.text = @"懒人电台";
        cell.subTitleLabel.text = @"智能化个性电台，一键收听";
        return cell;

    }else if (indexPath.section == 2){
        RCDiscoverItemViewCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCellID forIndexPath:indexPath];

      [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.discoverData.latest_special.coverPathSmall] placeholderImage:[UIImage imageNamed:@"finditem_hotsound_expand"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
          cell.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
      }];
        cell.titleLabel.text = @"专题";
        cell.subTitleLabel.text = self.viewModel.discoverData.latest_special.title;
        cell.hotView.hidden = !self.viewModel.discoverData.latest_special.isHot;

        return cell;

    }
    else if (indexPath.section == 3){
        RCDiscoverItemViewCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCellID forIndexPath:indexPath];

        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.discoverData.latest_activity.coverPathSmall] placeholderImage:[UIImage imageNamed:@"finditem_hotsound_expand"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cell.iconView.image = [UIImage circleImage:image borderWidth:0 borderColor:nil];
        }];
        cell.titleLabel.text = @"热门活动";
        cell.subTitleLabel.text = self.viewModel.discoverData.latest_activity.title;
        cell.hotView.hidden = !self.viewModel.discoverData.latest_activity.isHot;
        return cell;
    }
    else if (indexPath.section == 4){
        RCDiscoverItemViewCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCellID forIndexPath:indexPath];
        [cell.iconView setImage:[UIImage circleImageWithName:@"finditem_zone" borderWidth:0 borderColor:nil]];
        cell.titleLabel.text = @"圈子";
        cell.subTitleLabel.text = self.viewModel.discoverData.latest_activity.title;;
        cell.hotView.hidden = !self.viewModel.discoverData.latest_activity.isHot;

        return cell;
    }else if (indexPath.section == 5){
        RCRecommendAlbumViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TableviewCellID];

        cell.list = self.viewModel.recommendAlbums[indexPath.row];

        return cell;
    
    }else if (indexPath.section == 6){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"todayCell"];
        }
        [cell.imageView setImage:[UIImage imageNamed:@"finditem_wallspoint"]];
        cell.textLabel.text = @"今日特价";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"lastCell"];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"finditem_ad"]];
    cell.textLabel.text = @"精选应用";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;    }

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 5) {
        RCSectionheaderView * headerView = [RCSectionheaderView headerView];
        [[headerView.titleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        }];
        return headerView;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section== 5) {
        return 30;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RCLog(@"didSelectRowAtIndexPath");
    if (indexPath.section == 2) {
        [self.navigationController pushViewController:[[RCSubjectViewController alloc]init] animated:YES];
    }
}

#pragma mark - private
- (UICollectionView *)setUpConllectionViewWithLayout:(UICollectionViewFlowLayout *)layout{
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    return collectionView;
}
#pragma mark - 定时器
/**
 *  添加定时器
 */
- (void)addTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;

}
/**
 *  移除定时器
 */
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (NSIndexPath *)resetedIndexPath{
    if ( self.viewModel.focusImages.count  >=2) {


        //    RCLog(@"resetedIndexPath-----%ld",(long)self.pageControl.numberOfPages);
        NSIndexPath * currentIndexPath = [[self.scrollCollectionView indexPathsForVisibleItems] firstObject];

        //滚动到最中间
        NSIndexPath * currentReSetIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:sectionCount*0.5];

        [self.scrollCollectionView scrollToItemAtIndexPath:currentReSetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        return currentReSetIndexPath;
    }
    return nil;
}
- (void)nextPage{

    //获取当前滚动位置
    NSIndexPath * currentIndexPath = [self resetedIndexPath];
    NSInteger nextItem = currentIndexPath.item +1;
    NSInteger nextSection = currentIndexPath.section;

    //滚动到下一页
    if (nextItem == self.viewModel.focusImages.count ) {
        nextItem = 0;
        nextSection ++;
    }
    if (self.viewModel.focusImages.count   != 0) {
        NSIndexPath * nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        [self.scrollCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}
@end
