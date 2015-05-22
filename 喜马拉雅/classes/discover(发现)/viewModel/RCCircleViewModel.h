//
//  RCCircleViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewModel.h"
#import "RCRecommendedZones.h"
#import "RCRecommendedPost.h"
@interface RCCircleViewModel : NSObject
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
@end
