//
//  RCAlbumTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAlbum.h"
@interface RCAlbumTool : NSObject
+ (void)saveAlbum:(RCAlbum *)album;
+ (void)removealbum:(RCAlbum *)album;
+ (void)removeAllAlbum;
+ (NSArray *)albumsWithPage:(NSUInteger )page;
+ (RCAlbum *)album;
+ (NSUInteger)albumCount;
+ (BOOL)isCollectAlbum:(RCAlbum *)album;
@end
