//
//  RCOnneHotAudio.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOnneHotAudio.h"
#import "MJExtension.h"
#import "NSDate+RC.h"
@implementation RCOnneHotAudio
+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{@"ID":@"id"};
}
- (NSString *)created_at{
    // _created_at == Fri May 09 16:30:34 +0800 2014

    NSDate * date = [NSDate dateWithNumber:_createdAt];

    // 1.获得微博的发送时间
    NSDateFormatter *fmt                       = [[NSDateFormatter alloc] init];
    //#warning 真机调试下, 必须加上这段
    fmt.locale                                 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    // 2..判断微博发送时间 和 现在时间 的差距
    if (date.isToday) { // 今天
        if (date.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)date.deltaWithNow.hour];
        } else if (date.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)date.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (date.isYesterday) { // 昨天
        fmt.dateFormat                             = @"昨天";
        return [fmt stringFromDate:date];
    } else if (date.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat                             = @"MM/dd";
        return [fmt stringFromDate:date];
    } else { // 非今年
        fmt.dateFormat                             = @"MM/YYYY";
        return [fmt stringFromDate:date];
    }
    
}
@end
