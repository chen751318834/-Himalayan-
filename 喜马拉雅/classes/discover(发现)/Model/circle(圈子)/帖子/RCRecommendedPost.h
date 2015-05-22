//
//  RCRecommendedPost.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
// 热门帖子

#import <Foundation/Foundation.h>
#import "RCRecommendPoster.h"
@interface RCRecommendedPost : NSObject
/**
 *   "id": 1398,
 "zoneId": 32,
 "isTop": false,
 "isPrime": false,
 "isDeleted": false,
 "createdTime": 1416989674000,
 "updatedTime": 1432270072000,
 "title": "我该为了老公全职吗",
 "timeline": 90065426449782,
 "canBeDeleted": false,
 "content": "我06年本科毕业来北京，
 "numOfComments": 28,
 "isContentIntact": true,
 "poster": {},
 "images": [ ]
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *zoneId;
@property(nonatomic,strong) NSNumber  *createdTime;
@property(nonatomic,strong) NSNumber  *updatedTime;
@property(nonatomic,strong) NSNumber  *timeline;
@property(nonatomic,strong) NSNumber  *numOfComments;
@property(nonatomic,assign) BOOL isTop;
@property(nonatomic,assign) BOOL isPrime;
@property(nonatomic,assign) BOOL isDeleted;
@property(nonatomic,assign) BOOL isContentIntact;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *content;
@property(nonatomic,strong) NSArray  *images;
@property(nonatomic,strong) RCRecommendPoster  *poster;
@property(nonatomic,copy) NSString  *created_at;

@end
