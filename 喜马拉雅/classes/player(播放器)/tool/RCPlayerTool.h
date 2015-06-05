//
//  RCPlayerTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCPlayerInfo.h"
@interface RCPlayerTool : NSObject
+ (void)savePlayedAudio:(RCPlayerInfo *)playedAudio;
+ (void)removePlayedAudio:(RCPlayerInfo *)playedAudio;
+ (void)removeAllPlayedAudio;
+ (NSArray *)playedAudiosWithPage:(NSUInteger )page;
+ (NSUInteger)playedAudioCount;
+ (BOOL)isCollectPlayedAudio:(RCPlayerInfo *)album;
@end
