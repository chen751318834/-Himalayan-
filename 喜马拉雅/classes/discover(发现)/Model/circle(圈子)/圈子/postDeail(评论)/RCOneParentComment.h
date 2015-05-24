//
//  RCOneParentComment.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RCRecommendPoster.h"
@interface RCOneParentComment : NSObject
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *createdTime;
@property(nonatomic,copy) NSString  *created_at;

@property(nonatomic,strong) NSNumber  *updatedTime;
@property(nonatomic,strong) NSNumber  *numOfFloor;
@property(nonatomic,strong) NSNumber  *postId;
@property(nonatomic,strong) NSNumber  *timeline;
@property(nonatomic,copy) NSString  *content;
@property(nonatomic,strong) NSArray  *images;
@property(nonatomic,assign) BOOL canBeDeleted;
@property(nonatomic,strong) RCRecommendPoster  *poster;
@end
