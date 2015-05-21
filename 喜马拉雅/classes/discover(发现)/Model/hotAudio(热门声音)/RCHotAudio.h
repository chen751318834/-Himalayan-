//
//  RCHotAudio.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCHotAudio : NSObject
/**
 *   "ret": 0,
 "maxPageId": 67,
 "count": 1000,
 "list": []
 */
@property(nonatomic,strong) NSNumber  *ret;
@property(nonatomic,strong) NSNumber  *maxPageId;
@property(nonatomic,strong) NSNumber  *count;
@property(nonatomic,strong) NSArray  *list;
@end
