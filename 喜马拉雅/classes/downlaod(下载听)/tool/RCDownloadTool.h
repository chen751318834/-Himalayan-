//
//  RCDownloadTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAlbum.h"
#import "RCTrackList.h"
@interface RCDownloadTool : NSObject
/**
 *  专辑
 *
 */
+ (void)saveDownloadAlbum:(RCAlbum *)downloadAlbum;
+ (void)removeDownloadAlbum:(RCAlbum *)downloadAlbum;
+ (void)removeAllDownloadAlbum;
+ (NSArray *)downloadAlbumsWithPage:(NSUInteger )page;
+ (NSArray *)downloadAlbums;
+ (NSUInteger)downloadAlbumCount;
+ (BOOL)isDownloaddAlbum:(RCAlbum *)downloaddAlbum;
/**
 *  声音
 *
 */
+ (void)saveDownloadAudio:(RCTrackList *)downloadAudio;
+ (void)removeDownloadAudio:(RCTrackList *)downloadAudio;
+ (void)removeAllDownloadAudio;
+ (NSArray *)downloadAudiosWithPage:(NSUInteger )page;
+ (NSArray *)downloadAudios;
+ (NSUInteger)downloadAudioCount;
+ (BOOL)isDownloadAudio:(RCTrackList *)downloadAudio;

@end
