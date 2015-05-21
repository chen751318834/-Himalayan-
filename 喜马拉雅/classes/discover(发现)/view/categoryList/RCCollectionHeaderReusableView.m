//
//  RCCollectionHeaderReusableView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCollectionHeaderReusableView.h"
#import "UIView+AutoLayout.h"
#import "RCCategoryFocusImageViewCell.h"
@implementation RCCollectionHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout * scrollLayout = [[UICollectionViewFlowLayout alloc]init];
        scrollLayout.itemSize = CGSizeMake(self.bounds.size.width, 160);
        scrollLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        scrollLayout.minimumLineSpacing = 0;
        scrollLayout.minimumInteritemSpacing = 0;

        UICollectionView * scrollCollectionView =  [self setUpConllectionViewWithLayout:scrollLayout];
        scrollCollectionView.pagingEnabled = YES;
        scrollCollectionView.showsHorizontalScrollIndicator = NO;
            self.scrollCollectionView = scrollCollectionView;
        [self addSubview:scrollCollectionView];

        UIPageControl * pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        [scrollCollectionView registerClass:[RCCategoryFocusImageViewCell class] forCellWithReuseIdentifier:@"categoryFocusImageCell"];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.pageControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.pageControl autoSetDimension:ALDimensionHeight toSize:20];
    [self.scrollCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

}
#pragma mark - private
- (UICollectionView *)setUpConllectionViewWithLayout:(UICollectionViewFlowLayout *)layout{
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    return collectionView;
}
@end
