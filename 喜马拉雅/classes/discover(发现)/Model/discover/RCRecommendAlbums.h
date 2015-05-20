//
//  RCRecommendAlbums.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RCRecommendAlbums : NSObject
/**
 *   "ret": 0,
 "maxPageId": 125,
 "count": 1000,
 "list": []
 */
@property(nonatomic,strong) NSNumber  *ret;
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *count;
@property(nonatomic,strong) NSArray  *list;
@end
