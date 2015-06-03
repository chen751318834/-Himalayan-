//
//  RCTextViewTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTextViewTool.h"
#import "NSDate+RC.h"
#import "RegexKitLite.h"
#import "HWEmotionTool.h"
#import "RCTextPart.h"
#import <UIKit/UIKit.h>
#import "HWEmotion.h"
#import "RCSpecialText.h"
@implementation RCTextViewTool
/**
 *  返回一个带有属性的文字
 *
 *  @param text 普通文字
 *
 *  @return 带有属性的文字
 */
+ (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]init];

    // 表情的规则
    NSString *emotionPattern                   = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern                        = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern                     = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern                       = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";

    NSString *pattern                          = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    //存放textPart模型的shuj
    NSMutableArray * textParts                 = [NSMutableArray array];
    //遍历所有的特殊字符
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        RCTextPart * part                          = [[RCTextPart alloc]init];
        part.text                                  = *capturedStrings;
        part.range                                 = *capturedRanges;
        part.specialText                           = YES;
        part.emotion                               = [*capturedStrings hasPrefix:@"["]&&[* capturedStrings hasSuffix:@"]"];
        [textParts addObject:part];
    }];


    //遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        RCTextPart * part                          = [[RCTextPart alloc]init];
        part.text                                  = *capturedStrings;
        part.range                                 = *capturedRanges;
        part.specialText                           = NO;
        part.emotion                               = NO;
        [textParts addObject:part];
    }];
    //对数组进行排序

    [textParts sortUsingComparator:^NSComparisonResult(RCTextPart * part1,  RCTextPart * part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;

    }];
    UIFont * font                              = [UIFont systemFontOfSize:15];
    /**
     *  创建存放特殊字符的数组
     */
    NSMutableArray * specials = [NSMutableArray array];
    for (RCTextPart * part in  textParts) {
        NSLog(@"%@",part);

        NSAttributedString * subText               = nil;
        if (part.isEmotion) {
            HWEmotion * emotion = [HWEmotionTool emotionWithChs:part.text];
            if (emotion) {
                NSTextAttachment * atta                    = [[NSTextAttachment alloc]init];
                atta.image                                 = [UIImage imageNamed:emotion.png];
                atta.bounds                                = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                subText                                    = [NSAttributedString attributedStringWithAttachment:atta];
            }else{
                subText = [[NSAttributedString alloc]initWithString:part.text];

            }
        }else if (part.isSpecialText){

            subText                                    = [[NSAttributedString alloc]initWithString:part.text attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.644 green:0.712 blue:0.931 alpha:1.000]}]  ;
            //创建RCSpecialText模型
            RCSpecialText * special = [[RCSpecialText alloc]init];
            special.text = part.text;
            special.range = NSMakeRange(attributedText.length, part.text.length);
            [specials addObject:special];
            //添加RCSpecialText模型作为attributedText的属性
            //            NSLog(@"specials=======%@",specials);
        }else{
            subText                                    = [[NSAttributedString alloc]initWithString:part.text];
            //

        }

        [attributedText appendAttributedString:subText];

    }

    //设置字体
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];

    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    
    
    return attributedText;
    
    
}
@end
