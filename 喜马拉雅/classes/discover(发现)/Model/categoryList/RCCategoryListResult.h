//
//  RCCategoryListResult.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCategoryListResult : NSObject
/**
 *    "ret": 0,
 "maxPageId": 1,
 "count": 18,
 "list": [],
 "hasRecommendedZones": true
 */
@property(nonatomic,strong) NSNumber  *ret;
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *count;
@property(nonatomic,strong) NSArray  *list;
@property(nonatomic,assign) BOOL hasRecommendedZones;

@end
