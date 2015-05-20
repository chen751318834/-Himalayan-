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
#import "RCFocusImageViewCell.h"
#import "RCCategoryListResult.h"
#import "RCCategryListParam.h"
#import "RCCategoryListViewCell.h"
@interface RCCateroryListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView   *collectionView;
@property(nonatomic,strong) RCCategoryListViewModel  *viewModel;
@property(nonatomic,weak) UICollectionView   *scrollCollectionView;

@end

@implementation RCCateroryListViewController
static NSString * const imgID = @"imgCell";
static NSString * const reuseIdentifier = @"categaoryListCell";
#pragma mark - 懒加载
-  (RCCategoryListViewModel *)viewModel{
    if (!_viewModel) {
         self.viewModel = [[RCCategoryListViewModel alloc]init];
        self.viewModel.category = self.category;

    }
    return _viewModel;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.category.itemTitle;
    [self setUpCollectionView];
    [self.viewModel fetchCategoryListWithSuccess:^{
        [self.collectionView reloadData];
    } failure:^{
  
    }];

    [self.viewModel fetchCategoryFocusImageWithSuccess:^{
        [self.collectionView reloadData];

    } failure:^{

    }];
}

- (void)setUpCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat margin = 10;
    NSUInteger counlmCount = 3;
    CGFloat itemWidth = (self.view.frame.size.width - (margin *(counlmCount +1)))/counlmCount;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
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

    [self.collectionView registerNib:[UINib nibWithNibName:@"RCCategoryListViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    [self.collectionView registerNib:[UINib nibWithNibName:@"RCFocusImageViewCell" bundle:nil] forCellWithReuseIdentifier:imgID];
//
//    UICollectionViewFlowLayout * scrollLayout = [[UICollectionViewFlowLayout alloc]init];
//    scrollLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 200);
//    scrollLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    scrollLayout.minimumLineSpacing = 0;
//    scrollLayout.minimumInteritemSpacing = 0;
//    UICollectionView * scrollCollectionView =  [self setUpConllectionViewWithLayout:scrollLayout];
//    self.scrollCollectionView = scrollCollectionView;
//    scrollCollectionView.backgroundColor = [UIColor redColor];
//    [self.scrollCollectionView registerClass:[RCFocusImageViewCell class] forCellWithReuseIdentifier:imgID];
//    scrollCollectionView.pagingEnabled = YES;
//    scrollCollectionView.showsHorizontalScrollIndicator = NO;
//    [collectionView addSubview:scrollCollectionView];
//    [scrollCollectionView autoSetDimension:ALDimensionHeight toSize:200];
//    [scrollCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
//    



}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return [self.viewModel numberOfSectionsInCollectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemInSectionInCollectionView:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        RCFocusImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imgID forIndexPath:indexPath];
//        cell.list = [self.viewModel categoryFocusImageAtIndexPathInCollectionView:indexPath];
//        return cell;
//    }
    RCCategoryListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.list = [self.viewModel categoryListAtIndexPathInCollectionView:indexPath];
    return cell;

}

#pragma mark <UICollectionViewDelegate>


#pragma mark - private
- (UICollectionView *)setUpConllectionViewWithLayout:(UICollectionViewFlowLayout *)layout{
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    return collectionView;
}
@end
