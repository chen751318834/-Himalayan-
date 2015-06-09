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
+ (void)saveDownloadAlbum:(RCTrackList *)downloadAlbum;
+ (void)removeDownloadAlbum:(RCTrackList *)downloadAlbum;
+ (void)removeAllDownloadAlbum;
+ (NSArray *)downloadAlbumsWithPage:(NSUInteger )page;
+ (NSArray *)downloadAlbums;
+ (NSUInteger)downloadAlbumCount;
+ (NSArray *)downloadAudiosWithAlbumId:(NSNumber *)albumId;
//+ (BOOL)isDownloaddAlbum:(RCAlbum *)downloaddAlbum;
/**
 *  已经下载的声音
 *
 */
+ (void)saveDownloadAudio:(RCTrackList *)downloadAudio;
+ (void)removeDownloadAudio:(RCTrackList *)downloadAudio;
+ (void)removeAllDownloadAudio;
+ (NSArray *)downloadAudiosWithPage:(NSUInteger )page;
+ (NSArray *)downloadAudios;
+ (NSUInteger)downloadAudioCount;
+ (BOOL)isDownloadAudio:(RCTrackList *)downloadAudio;
/**
 *  正在下载的声音
 *
 */
+ (void)saveDownloadingAudio:(RCTrackList *)downloadingAudio;
+ (void)removeDownloadingAudio:(RCTrackList *)downloadingAudio;
+ (void)removeAllDownloadingAudio;
+ (NSArray *)downloadingAudios;
+ (NSUInteger)downloadingAudioCount;
+ (BOOL)isDownloadingAudio:(RCTrackList *)downloadingAudio;

@end
