//
//  RCDisCoverViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RCList.h"
#import "RCCatrgory.h"
#import "RCDiscoverData.h"
#import "ReactiveCocoa.h"
@interface RCDisCoverViewModel : NSObject

/**
 *  collectionView
 *
 */
- (NSInteger)numberOfSectionsInCollectionView;
- (NSInteger)numberOfItemInSectionInCategoryCollectionView:(NSInteger)section;
- (NSInteger)numberOfItemInSectionInImgCollectionView:(NSInteger)section;
- (RCCatrgory *)categoryAtIndexPathInCollectionView: (NSIndexPath *)indexPath;
- (RCList *)imgAtIndexPathInCollectionView: (NSIndexPath *)indexPath;
- (NSMutableArray *)focusImages;

/**
 *  网络请求
 */
- ( void)fetchDiscoverDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
/**
 *  tableview
 */
- (NSInteger)numberOfSectionsInTableView;
- (NSInteger)numberOfItemInSectionInTableView: (NSInteger)section;
- (RCCatrgory *)itemAtIndexPathInTableView: (NSIndexPath *)indexPath;
- (CGFloat)cellHeihtWithIndexPath:(NSIndexPath *)indexPath;
- (NSMutableArray *)latest_specials;
- (NSMutableArray *)latest_activitys;
- (NSMutableArray *)recommendAlbums;
@property(nonatomic,strong) RCDiscoverData  *discoverData;
@end