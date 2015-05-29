//
//  RCAttentionOneData.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAttentionOneData.h"
#import "NSDate+RC.h"
@implementation RCAttentionOneData
- (NSString *)updateTime{
    // _created_at == Fri May 09 16:30:34 +0800 2014

    NSDate * date = [NSDate dateWithNumber:_lastUpdateAt];
    NSDateFormatter *fmt                       = [[NSDateFormatter alloc] init];
    //#warning 真机调试下, 必须加上这段
    fmt.locale                                 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    if (date.isToday) { // 今天
        if (date.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)date.deltaWithNow.hour];
        } else if (date.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)date.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (date.isYesterday) { // 昨天
        fmt.dateFormat                             = @"昨天 hh:mm";
        return [fmt stringFromDate:date];
    } else if (date.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat                             = @"MM-dd hh:mm";
        return [fmt stringFromDate:date];
    } else { // 非今年
        fmt.dateFormat                             = @"YYYY-MM-dd hh:mm";
        return [fmt stringFromDate:date];
    }
}
@end
