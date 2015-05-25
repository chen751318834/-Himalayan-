//
//  RCOneParentComment.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOneParentComment.h"
#import "MJExtension.h"
#import "NSDate+RC.h"
#import "RegexKitLite.h"
#import "HWEmotionTool.h"
#import "RCTextPart.h"
#import <UIKit/UIKit.h>
#import "RCSpecialText.h"
#import "HWEmotion.h"
@implementation RCOneParentComment
+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{@"ID":@"id"};
}
- (NSString *)created_at{
    // _created_at == Fri May 09 16:30:34 +0800 2014

    NSDate * date = [NSDate dateWithNumber:_createdTime];
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
        fmt.dateFormat                             = @"昨天";
        return [fmt stringFromDate:date];
    } else if (date.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat                             = @"MM-dd mm:ss";
        return [fmt stringFromDate:date];
    } else { // 非今年
        fmt.dateFormat                             = @"MM-YYYY";
        return [fmt stringFromDate:date];
    }
    
}

- (void)setContent:(NSString *)content{
    _content = [content copy];
    self.attributedContent = [self attributedTextWithText:content];
}
/**
 *  返回一个带有属性的文字
 *
 *  @param text 普通文字
 *
 *  @return 带有属性的文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]init];

    // 表情的规则
    NSString *emotionPattern                   = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";


    //存放textPart模型的shuj
    NSMutableArray * textParts                 = [NSMutableArray array];
    //遍历所有的特殊字符
    [text enumerateStringsMatchedByRegex:emotionPattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedStrings).length == 0) return;
        RCTextPart * part                          = [[RCTextPart alloc]init];
        part.text                                  = *capturedStrings;
        part.range                                 = *capturedRanges;
        part.emotion                               = YES;
        [textParts addObject:part];
    }];


    //遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:emotionPattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedStrings).length == 0) return;

        RCTextPart * part                          = [[RCTextPart alloc]init];
        part.text                                  = *capturedStrings;
        part.range                                 = *capturedRanges;
        part.emotion                               = NO;
        [textParts addObject:part];
    }];
    //对数组进行排序

    [textParts sortUsingComparator:^NSComparisonResult(RCTextPart * part1,  RCTextPart * part2) {
        //NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        if (part1.range.location > part2.range.location) {
        return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    UIFont * font            = [UIFont systemFontOfSize:13];
    for (RCTextPart * part in  textParts) {
        NSAttributedString * subText               = nil;
        if (part.isEmotion) {
            HWEmotion * emotion = [HWEmotionTool emotionWithChs:part.text];

                NSTextAttachment * atta                    = [[NSTextAttachment alloc]init];
                atta.image                                 = [UIImage imageNamed:emotion.png];
                atta.bounds                                = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                subText                                    = [NSAttributedString attributedStringWithAttachment:atta];

        }else{
            subText  = [[NSAttributedString alloc]initWithString:part.text];
        }

        [attributedText appendAttributedString:subText];

    }
    //设置字体
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    NSLog(@"%@",attributedText);
    return attributedText;
    
    
}
@end
