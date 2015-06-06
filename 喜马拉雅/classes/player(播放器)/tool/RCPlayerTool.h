//
//  RCPlayerTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/5.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCPlaylist.h"
@interface RCPlayerTool : NSObject
+ (void)savePlayedAudio:(RCPlaylist *)playedAudio;
+ (void)removePlayedAudio:(RCPlaylist *)playedAudio;
+ (void)removeAllPlayedAudio;
+ (NSArray *)playedAudiosWithPage:(NSUInteger )page;
+ (NSArray *)playedAudios;
+ (NSUInteger)playedAudioCount;
+ (BOOL)isCollectPlayedAudio:(RCPlaylist *)album;
@end
