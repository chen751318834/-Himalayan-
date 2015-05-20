//
//  RCCategoryListViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCCategoryList.h"
#import "RCCatrgory.h"
#import "RCList.h"
@interface RCCategoryListViewModel : NSObject
@property(nonatomic,strong) RCCatrgory  *category;

/**
 *  collectionView
 *
 */
- (NSInteger)numberOfSectionsInCollectionView;
- (NSInteger)numberOfItemInSectionInCollectionView:(NSInteger)section;
- (NSInteger)numberOfItemInSectionInIMgCollectionView:(NSInteger)section;

- (RCCategoryList *)categoryListAtIndexPathInCollectionView: (NSIndexPath *)indexPath;
- (RCList *)categoryFocusImageAtIndexPathInCollectionView: (NSIndexPath *)indexPath;

/**
 *  网络请求
 */
- ( void)fetchCategoryListWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchCategoryFocusImageWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;

@end
