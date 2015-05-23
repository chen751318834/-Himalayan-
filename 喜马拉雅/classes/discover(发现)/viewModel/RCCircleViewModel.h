//
//  RCCircleViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewModel.h"
#import "RCRecommendedZones.h"
#import "RCZonePost.h"
#import "RCZonePostHeadData.h"
#import "RCRecommendedPost.h"
#import "RCBaseViewModel.h"

@interface RCCircleViewModel : RCBaseViewModel
#pragma mark - 圈子

- (RCRecommendedZones *)zoneAtIndexPath: (NSIndexPath *)indexPath;
- (RCRecommendedPost *)postAtIndexPath: (NSIndexPath *)indexPath;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowInSection: (NSInteger)section;
- (NSString *)titleOfRowInSection: (NSInteger)section;


/**
 *  网络请求
 */
- ( void)fetchRecommendZoneDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- ( void)fetchRecommendPostDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;

#pragma mark - 圈子详情



@property(nonatomic,strong) NSNumber  *zoneID;
@property(nonatomic,strong) NSNumber  *timeline;

- ( void)fetchZonesAndPostDeailHeaderDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- ( void)fetchNewZonesAndPostDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- ( void)fetchMoreZonesAndPostDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

- (NSInteger)numberOfRowOfZonePostInSection: (NSInteger)section;
- (RCZonePost *)zonePostAtIndexPath: (NSIndexPath *)indexPath;
@property(nonatomic,strong) RCZonePostHeadData  *headData;
@end
