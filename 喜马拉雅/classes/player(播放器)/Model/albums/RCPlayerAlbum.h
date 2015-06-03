//
//  RCPlayerAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCPlayerAlbum : NSObject
/**
 *   "albumId": 421726,
 "title": "五虎演义",
 "coverSmall": "http://fdfs.xmcdn.com/group8/M0B/04/32/wKgDYVVSwruTwsT7AABUjfuN8ts521_mobile_small.jpg",
 "updatedAt": 1431487998000,
 "tracks": 80,
 "recSrc": "cf1",
 "recTrack": "ra"
 */
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *recSrc;
@property(nonatomic,copy) NSString  *recTrack;

@end
