//
//  RCCategoryListViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCategoryListViewModel.h"
#import "RCCategryListParam.h"
#import "RCCategoryListResult.h"
#import "RCDiscoverDataTool.h"
#import "RCCategoryFocusImageParam.h"
#import "RCCategoryFocusImageResult.h"
#import <UIKit/UIKit.h>
#import "RCList.h"
#import "RCConst.h"
@interface RCCategoryListViewModel ()
@property(nonatomic,strong) NSMutableArray  *categoryLists;
@property(nonatomic,strong) NSMutableArray  *categoryFocusImages;

@end
@implementation RCCategoryListViewModel
-  (NSMutableArray *)categoryFocusImages{
    if (!_categoryFocusImages) {
        self.categoryFocusImages = [NSMutableArray array];

    }
    return _categoryFocusImages;
}
-  (NSMutableArray *)categoryLists{
    if (!_categoryLists) {
        self.categoryLists = [NSMutableArray array];

    }
    return _categoryLists;
}
- (void)fetchCategoryListWithSuccess:(void (^)(void))success failure:(void (^)(void))failure{
    RCCategryListParam * param = [RCCategryListParam param];
// device=android&per_page=100&category=all&type=album&page=1
   param.device = @"android";
    param.per_page = @100;
    param.category = self.category.itemName;
    param.page = @1;
    param.type = @"album";
    [RCDiscoverDataTool categoryListWithParam:param success:^(RCCategoryListResult *result) {
        [self.categoryLists addObjectsFromArray:result.list];
        success();
    } failure:^(NSError *error) {
        RCLog(@"%@",error);
        failure();
    }];
}
- ( void)fetchCategoryFocusImageWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    RCCategoryFocusImageParam * param = [[RCCategoryFocusImageParam alloc]init];
    // categoryId=3&version=3.25.7.1&device=android
    param.version = @"3.25.7.1";
    param.categoryId = self.category.itemKey;
    param.device = @"android";
    [RCDiscoverDataTool categoryFocusImageWithParam:param
      success:^(RCCategoryFocusImageResult *result) {
          [self.categoryFocusImages addObjectsFromArray:result.list];
          RCLog(@"%@",self.categoryFocusImages);
          success();
    } failure:^(NSError *error) {
        RCLog(@"%@",error);
        failure();
    }];
}
- (NSInteger)numberOfSectionsInCollectionView{
    return 1;
}

- (NSInteger)numberOfItemInSectionInCollectionView:(NSInteger)section{

    return self.categoryLists.count;
}
- (NSInteger)numberOfItemInSectionInIMgCollectionView:(NSInteger)section{

    return self.categoryFocusImages.count;
}
- (RCCategoryList *)categoryListAtIndexPathInCollectionView: (NSIndexPath *)indexPath{
    return self.categoryLists[indexPath.item];
}
- (RCList *)categoryFocusImageAtIndexPathInCollectionView: (NSIndexPath *)indexPath{

    return self.categoryFocusImages[indexPath.item];
}
@end
