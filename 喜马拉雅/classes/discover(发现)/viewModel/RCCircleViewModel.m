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
@property(nonatomic,strong) NSMutableArray  *topPosts;
@property(nonatomic,strong) NSMutableArray  *comments;
@property(nonatomic,strong) NSMutableArray  *parentComments;
@property(nonatomic,strong) NSMutableArray  *onwerDatas;

@end
@implementation RCCircleViewModel
-  (NSMutableArray *)onwerDatas{
    if (!_onwerDatas) {
        self.onwerDatas = [NSMutableArray array];
    }
    return _onwerDatas;
}
- (NSMutableArray *)posts{
    if (!_posts) {
        self.posts= [NSMutableArray array];

    }
    return _posts;
}

-  (NSMutableArray *)comments{
    if (!_comments) {
        self.comments= [NSMutableArray array];

    }
    return _comments;
}
-  (NSMutableArray *)parentComments{
    if (!_parentComments) {
        self.parentComments= [NSMutableArray array];

    }
    return _parentComments;
}
-  (NSMutableArray *)topPosts{
    if (!_topPosts) {
        self.topPosts= [NSMutableArray array];

    }
    return _topPosts;
}
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
    if (self.posts.count ==0) return  nil;
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
        NSArray * newZonePosts = [RCZonePost objectArrayWithKeyValuesArray:json[@"result"]];
        [self.zonePosts removeAllObjects];
        [self.topPosts removeAllObjects];
        [newZonePosts enumerateObjectsUsingBlock:^(RCZonePost * obj, NSUInteger idx, BOOL *stop) {
            if (obj.isTop) {
                [self.topPosts addObject:obj];
            }else{
                [self.zonePosts addObject:obj];
            }
        }];
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
            NSArray * newZonePosts = [RCZonePost objectArrayWithKeyValuesArray:json[@"result"]];
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
- (NSInteger)numberOfRowOfZonePostInSection: (NSInteger)section{
    if (section == 0) {
        return self.topPosts.count;
    }
    return self.zonePosts.count;
}
- (RCRecommendedPost *)zonePostAtIndexPath: (NSIndexPath *)indexPath{
    return self.zonePosts[indexPath.row];

}
- (RCRecommendedPost *)topZonePostAtIndexPath: (NSIndexPath *)indexPath{
    return self.topPosts[indexPath.row];
    
}

#pragma mark - 评论详情
- ( void)fetchBulidingOnwerDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {
    NSString * urlStr = [NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/posts/%@?device=android&zoneId=%@",self.post.ID,self.post.zoneId];
    NSLog(@"%@",urlStr);
    [RCNetWorkingTool get:urlStr params:nil success:^(id json) {
        RCRecommendedPost * newComment = [RCRecommendedPost objectWithKeyValues:json[@"result"]];
        [self.onwerDatas removeAllObjects];
        [self.onwerDatas addObject:newComment];

        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];



}

- ( void)fetchNewCommentsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {
    NSString * urlStr = [NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/comments?order=0&timelineType=0&direction=0&device=android&timeline=0&maxSizeOfComments=30&zoneId=%@&postId=%@",self.post.zoneId,self.post.ID];
    NSLog(@"%@",urlStr);
    [RCNetWorkingTool get:urlStr params:nil success:^(id json) {
        RCComment * newComment = [RCComment objectWithKeyValues:json[@"result"]];
        [self.comments removeAllObjects];
        [self.parentComments removeAllObjects];
        [self.comments addObjectsFromArray:newComment.comments];
        if (newComment.parentComments.count != 0) {
            [self.comments addObjectsFromArray:newComment.parentComments];
        }
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMoreCommentsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    RCRecommendedPost * lastZonePost = [self.zonePosts lastObject];
    if (lastZonePost) {
        [RCNetWorkingTool get:[NSString stringWithFormat:@"http://xzone.ximalaya.com/x-zone-post/v1/comments?order=0&timelineType=0&direction=0&device=android&timeline=%@&maxSizeOfComments=30&zoneId=%@&postId=%@",lastZonePost.timeline,self.post.zoneId,self.post.ID] params:nil success:^(id json) {
            RCComment * newComment = [RCComment objectWithKeyValues:json[@"result"]];
            [self.comments addObjectsFromArray:newComment.comments];
            if (newComment.parentComments.count != 0) {
                [self.comments addObjectsFromArray:newComment.parentComments];
            }
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

- (RCOneComment *)commentAtIndexPath: (NSIndexPath *)indexPath{

    return self.comments[indexPath.row];
}
- (RCOneParentComment *)parentCommentAtIndexPath: (NSIndexPath *)indexPath{
    return self.parentComments[indexPath.row];
}
- (NSInteger)numberOfRowOfCommentInSection: (NSInteger)section{
    if (section == 0) {
        return self.onwerDatas.count;
    }
    return self.comments.count;
}
- (RCRecommendedPost *)onwerDataAtIndexPath: (NSIndexPath *)indexPath{
    return self.onwerDatas[indexPath.row];
}
@end
