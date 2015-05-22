//
//  NSDate+RC.h
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RC)
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 * 将数字转成日期
 */
- (NSString *)dateStrWithNumber:(NSNumber *)number;
- (NSDateComponents *)deltaWithNow;
+ (NSDate *)dateWithNumber:(NSNumber *)number;

@end
