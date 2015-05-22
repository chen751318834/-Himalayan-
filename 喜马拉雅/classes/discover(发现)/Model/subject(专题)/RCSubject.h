//
//  RCSubject.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSubject : NSObject
/**
 *   "ret": 0,
 "pageId": 1,
 "maxPageId": 20,
 "count": 200,
 "moduleTitle": "今日焦点",
 "list": []
 */
@property(nonatomic,strong) NSNumber  *ret;
@property(nonatomic,strong) NSNumber  *pageId;
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *count;
@property(nonatomic,copy) NSString  *moduleTitle;
@property(nonatomic,strong) NSArray  *list;

@end
