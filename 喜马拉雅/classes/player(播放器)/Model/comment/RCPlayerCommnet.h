//
//  RCPlayerCommnet.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCPlayerCommnet : NSObject
/**
 "maxPageId": 4,
 "totalCount": 55,
 "pageId": 1,
 "pageSize": 15,
 "list": [],
 */
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *totalCount;
@property(nonatomic,strong) NSNumber  *pageId;
@property(nonatomic,strong) NSNumber  *pageSize;
@property(nonatomic,strong) NSArray  *list;
@end
