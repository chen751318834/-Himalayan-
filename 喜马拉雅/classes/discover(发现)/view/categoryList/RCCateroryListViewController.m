//
//  RCCateroryListViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCateroryListViewController.h"
#import "RCConst.h"
#import "RCCategoryList.h"
#import "RCDiscoverDataTool.h"
#import "RCCategoryListViewModel.h"
#import "RCCollectionHeaderReusableView.h"
#import "RCCategoryListResult.h"
#import "RCCategryListParam.h"
#import "RCCategoryListViewCell.h"
#import "RCCategoryFocusImageViewCell.h"
@interface RCCateroryListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView   *collectionView;
@property(nonatomic,strong) RCCategoryListViewModel  *viewModel;
@property(nonatomic,weak) UIPageControl   *pageControl;
@property(nonatomic,weak) UICollectionView   *scrollCollectionView;
@property(strong,nonatomic) NSTimer * timer;
@end
@implementation RCCateroryListViewController
static NSString * const imgID = @"categoryFocusImageCell";
static NSString * const reuseIdentifier = @"categaoryListCell";
static const NSUInteger sectionCount = 100;

#pragma mark - 懒加载
-  (RCCategoryListViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCCategoryListViewModel alloc]init];
        self.viewModel.category = self.category;

    }
    return _viewModel;
}
#pragma mark - 初始化
//- (void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];
//    [self setUpConllectionLayoutWithCollectionWidth:self.view.width orientation:self.preferredInterfaceOrientationForPresentation];
//
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof(self) weekSelf = self;

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = self.category.itemTitle;
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"正在加载..."}];
    [self.viewModel fetchCategoryListWithSuccess:^{
        [weekSelf.collectionView reloadData];
        [KVNProgress dismiss];
    } failure:^{
        [KVNProgress dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress showError];
        });
    }];
    [KVNProgress showWithParameters:@{KVNProgressViewParameterStatus:@"正在加载..."}];
    [self.viewModel fetchCategoryFocusImageWithSuccess:^{
        [weekSelf.scrollCollectionView reloadData];
        [KVNProgress dismiss];
        [weekSelf addTimer];

    } failure:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress showError];
        });
    }];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];

}

- (void)setUpCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setHeaderReferenceSize:CGSizeMake(self.view.bounds.size.width, 160)];

    CGFloat margin = 10;
    NSUInteger counlmCount = 3;
    CGFloat itemWidth = (self.view.frame.size.width - (margin *(counlmCount +1)))/counlmCount;
    layout.itemSize = CGSizeMake(itemWidth, 115);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake( margin*0.5, margin, margin*0.5, margin);
    UICollectionView * collectionView  = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.collectionView  =  collectionView;
    [self.collectionView registerClass:[RCCollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RCCategoryListViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == self.scrollCollectionView) {
        return sectionCount;
    }
    return [self.viewModel numberOfSectionsInCollectionView];

 }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (collectionView == self.scrollCollectionView) {

                self.pageControl.numberOfPages = [self.viewModel numberOfItemInSectionInIMgCollectionView:section];

        return [self.viewModel  numberOfItemInSectionInIMgCollectionView:section];
    }
    return [self.viewModel numberOfItemInSectionInCollectionView:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.scrollCollectionView) {
        RCCategoryFocusImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgID forIndexPath:indexPath];
        cell.list = [self.viewModel categoryFocusImageAtIndexPathInCollectionView:indexPath];
        return cell;
    }
    RCCategoryListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.list = [self.viewModel categoryListAtIndexPathInCollectionView:indexPath];
    return cell;

}
#pragma mark -  添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{


    RCCollectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    self.scrollCollectionView = headerView.scrollCollectionView;
    self.scrollCollectionView.delegate = self;
    self.scrollCollectionView.dataSource = self;
    self.pageControl = headerView.pageControl;

        return headerView;
  
}


#pragma mark <UICollectionViewDelegate>


#pragma mark - 处理屏幕旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [self setUpConllectionLayoutWithCollectionWidth:self.view.height orientation:toInterfaceOrientation];
}
/**
 *  设置容器之间的间距
 *
 *  @param collectionWidth 整个容器的宽带
 *  @param orientation     屏幕方向
 */
- (void)setUpConllectionLayoutWithCollectionWidth:(CGFloat)collectionWidth orientation:(UIInterfaceOrientation)orientation{

    int colums = UIInterfaceOrientationIsPortrait(orientation) ?3:5;
    UICollectionViewFlowLayout * layout =(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    int LineSpacing =10;
    layout.minimumLineSpacing =LineSpacing;
    int InteritemSpacing = (collectionWidth - colums * layout.itemSize.width)/(colums +1);
    layout.minimumInteritemSpacing = InteritemSpacing;

    layout.sectionInset =UIEdgeInsetsMake(20,InteritemSpacing, 20, InteritemSpacing);
//    CGFloat margin = 10;
//    NSUInteger counlmCount = 3;
//    CGFloat itemWidth = (self.view.frame.size.width - (margin *(counlmCount +1)))/counlmCount;
//    layout.itemSize = CGSizeMake(itemWidth, 115);
//    layout.minimumInteritemSpacing = margin;
//    layout.minimumLineSpacing = margin;
//    layout.sectionInset = UIEdgeInsetsMake( margin*0.5, margin, margin*0.5, margin);

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
    if ( [self.viewModel numberOfItemInSectionInIMgCollectionView:0]  >=2) {


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
    if (nextItem == [self.viewModel numberOfItemInSectionInIMgCollectionView:0] ) {
        nextItem = 0;
        nextSection ++;
    }
    if ([self.viewModel numberOfItemInSectionInIMgCollectionView:0]   != 0) {
        NSIndexPath * nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        [self.scrollCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self addTimer];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self resetedIndexPath];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollCollectionView) {
        int currentPage = (int)(scrollView.contentOffset.x /scrollView.bounds.size.width+0.5)%[self.viewModel numberOfItemInSectionInIMgCollectionView:0];
        __weak typeof(self) weakSelf  = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.pageControl.currentPage = currentPage;

        }];
    }
    //
}
@end
