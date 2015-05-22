//
//  RCRecommendedZones.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
// 推荐圈子

#import <Foundation/Foundation.h>
#import "RCRecommendMyZone.h"
#import "RCRecommendOwnerZone.h"
@interface RCRecommendedZones : NSObject
/**
 *   "id": 45,
 "displayName": "晒书联盟",
 "imageUrl": "http://fdfs.xmcdn.com/group6/M09/1F/B3/wKgDhFTZ2iGQ4rzIAACLDiv8NII023_mobile_small.jpg",
 "numOfPosts": 370,
 "numOfMembers": 12608,
 "description": "好书求共享！",
 "createdAt": 1423563330000,
 "updatedAt": 1423563330000,
 "timeline": 0,
 "myZone": {},
 "owner": {}
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *numOfPosts;
@property(nonatomic,strong) NSNumber  *numOfMembers;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,strong) NSNumber  *timeline;
@property(nonatomic,copy) NSString  *displayName;
@property(nonatomic,copy) NSString  *imageUrl;
@property(nonatomic,copy) NSString  *desc;
@property(nonatomic,strong) RCRecommendMyZone  *myZone;
@property(nonatomic,strong) RCRecommendOwnerZone  *owner;
@property(nonatomic,assign,getter=isJoin) BOOL join;

@end
