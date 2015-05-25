//
//  RCTrack.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTrack : NSObject
/**
 *    "list": [],
 "pageId": 1,
 "pageSize": 15,
 "maxPageId": 18,
 "totalCount": 267
 */
@property(nonatomic,strong) NSArray  *list;
@property(nonatomic,strong) NSNumber  *pageId;
@property(nonatomic,strong) NSNumber  *pageSize;
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *totalCount;
@end
