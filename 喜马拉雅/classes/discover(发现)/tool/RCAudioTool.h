//
//  RCAudioTool.h
//  
//
//  Created by Raychen on 15/4/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAudioTool : NSObject
// 播放音效
// 传入需要 播放的音效文件名称
+ (void)playAudioWithFilename:(NSString  *)filename;

// 销毁音效
+ (void)disposeAudioWithFilename:(NSString  *)filename;

// 根据音乐文件名称播放音乐
+ (void)playMusicWithFilename:(NSString  *)filename;

// 根据音乐文件名称暂停音乐
+ (void)pauseMusicWithFilename:(NSString  *)filename;

// 根据音乐文件名称停止音乐
+ (void)stopMusicWithFilename:(NSString  *)filename;
+ (BOOL)isPlayingAudio;

@end
