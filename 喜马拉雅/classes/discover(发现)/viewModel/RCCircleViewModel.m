//
//  RCCircleViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCircleViewModel.h"
#import "RCNetWorkingTool.h"
#import "RCRecommendedZones.h"
#import <UIKit/UIKit.h>
@interface RCCircleViewModel ()
@property(nonatomic,strong) NSMutableArray  *zones;
@property(nonatomic,strong) NSMutableArray  *posts;
@property(nonatomic,strong) NSMutableArray  *zonePosts;
@end
@implementation RCCircleViewModel
-  (NSMutableArray *)zonePosts{
    if (!_zonePosts) {
        self.zonePosts= [NSMutableArray array];

    }
    return _zonePosts;
}
-  (NSMutableArray *)zones{
    if (!_zones) {
        self.zones= [NSMutableArray array];

    }
    return _zones;
}
-  (NSMutableArray *)posts{
    if (!_posts) {
        self.posts= [NSMutableArray array];

    }
    return _posts;
}

#pragma mark - 圈子
- ( void)fetchRecommendZoneDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/recommendedZones?device=android"] params:nil success:^(id json) {
        [self.zones removeAllObjects];
        NSArray * newAudios = [RCRecommendedZones objectArrayWithKeyValuesArray:json[@"result"]];
        [self.zones addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchRecommendPostDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/recommendedPosts?device=android"] params:nil success:^(id json) {
        [self.posts removeAllObjects];
        NSArray * newAudios = [RCRecommendedPost objectArrayWithKeyValuesArray:json[@"result"]];
        [self.posts addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }];

}
- (RCRecommendedZones *)zoneAtIndexPath: (NSIndexPath *)indexPath{
    return self.zones[indexPath.row];
}
- (RCRecommendedPost *)postAtIndexPath: (NSIndexPath *)indexPath{
    return self.posts[indexPath.row];


}
- (NSInteger)numberOfSections{
    return 2;
}
- (NSInteger)numberOfRowInSection: (NSInteger)section{
    if (section == 0) {
        return self.zones.count;
    }
    return self.posts.count;

}
- (NSString *)titleOfRowInSection: (NSInteger)section{
    if (section == 0) {
        return @"推荐圈子";
    }
    return @"热门帖子";
}

#pragma mark - 圈子详情
- (NSInteger)numberOfRowOfZonePostInSection: (NSInteger)section{
    return self.zonePosts.count;
}
- (RCZonePost *)zonePostAtIndexPath: (NSIndexPath *)indexPath{
    return self.zonePosts[indexPath.row];

}
- ( void)fetchZonesAndPostDeailHeaderDataWithSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/zones/%@?device=android",self.zoneID] params:nil success:^(id json) {
        [self.posts removeAllObjects];
        RCZonePostHeadData * headData = [RCZonePostHeadData objectWithKeyValues:json[@"result"]];
        self.headData = headData;
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchNewZonesAndPostDeailDataWithSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/posts?timelineType=0&device=android&timeline=%@&zoneId=%@&maxSizeOfPosts=30",self.timeline,self.zoneID] params:nil success:^(id json) {
        [self.posts removeAllObjects];
        NSArray * newZonePosts = [RCZonePost objectArrayWithKeyValuesArray:json[@"result"]];
        [self.zonePosts addObjectsFromArray:newZonePosts];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreZonesAndPostDeailDataWithSuccess:(void (^)(void))success failure:(void (^)(void))failure completion:(void (^)(void))completion{

    RCZonePost * lastZonePost = [self.zonePosts lastObject];
    if (lastZonePost) {
        [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/posts?timelineType=0&device=android&timeline=%@&zoneId=%@&maxSizeOfPosts=30",lastZonePost.timeline,self.zoneID] params:nil success:^(id json) {
            NSArray * newZonePosts = [RCZonePost objectArrayWithKeyValuesArray:json[@"result"][@"activityData"]];

            [self.zonePosts addObjectsFromArray:newZonePosts];
            if (success) {
                success();
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure();
            }
        }];
    }


}
@end
