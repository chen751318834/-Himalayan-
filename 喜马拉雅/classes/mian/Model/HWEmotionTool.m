//
//  HWEmotionTool.m
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//
#import "HWEmotionTool.h"
#import "HWEmotion.h"
#import "MJExtension.h"
#import "RCGroupEmoticon.h"
@implementation HWEmotionTool


static NSArray *_defaultEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        RCGroupEmoticon * groupEmotion  = [RCGroupEmoticon objectWithFilename:@"emoticon_default.plist"];
        _defaultEmotions = groupEmotion.emoticon_group_emoticons;
    }
    return _defaultEmotions;
}

+ (HWEmotion *)emotionWithChs:(NSString *)chs
{
    for (HWEmotion *emotion in [self defaultEmotions]) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    return nil;
}
@end
