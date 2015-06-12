//
//  RCSearchTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCSearchResultList.h"
@interface RCSearchTool : NSObject
+ (void)saveSearchHistory:(RCSearchResultList *)searchHistory;
+ (void)removeAllSearchHistory;
+ (NSArray *)searchHistorys;
@end
