//
//  RCSearchSoundResult.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSearchSoundResult : NSObject
/**
 *  "key": "逻辑思维",
 "list": [],
 "count": 3
 */
@property(nonatomic,copy) NSString  *key;
@property(nonatomic,strong) NSArray  *list;
@property(nonatomic,strong) NSNumber  *count;
@end
