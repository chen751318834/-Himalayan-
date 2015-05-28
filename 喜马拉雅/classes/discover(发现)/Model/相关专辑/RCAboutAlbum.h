//
//  RCAboutAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAboutAlbum : NSObject
/**
 *   "albumId": 403089,
 "title": "锵锵三人行",
 "coverSmall": "http://fdfs.xmcdn.com/group6/M00/7E/B3/wKgDg1VB6SqxBHBXAAB5DjNv-ys325_mobile_small.jpg",
 "updatedAt": 1431152697000,
 "tracks": 12,
 "recSrc": "cf1",
 "recTrack": "n"
 */
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *updateTime;
@property(nonatomic,assign,getter=isCollect) BOOL collect;


@end
