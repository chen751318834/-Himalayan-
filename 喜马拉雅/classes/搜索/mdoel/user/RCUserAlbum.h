//
//  RCUserAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCList.h"
@interface RCUserAlbum : NSObject
/**
 "maxPageId": 1,
 "pageId": 1,
 "pageSize": 2,
 "list": [],
 */
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *pageId;
@property(nonatomic,strong) NSNumber  *pageSize;
@property(nonatomic,strong) NSArray  *list;
@end
