//
//  RCPlaylist.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DOUAudioFile.h"
@interface RCPlaylist : NSObject
/**
 *    "trackId": 7156453,
 "uid": 8974779,
 "playUrl64": "http://fdfs.xmcdn.com/group12/M00/15/B9/wKgDW1Vu89bjxKWbAKTBKnzVJww517.mp3",
 "downloadUrl": "http://fdfs.xmcdn.com/group16/M02/15/E6/wKgDbFVu86Hy5FGeAFV6QnOJ45E727.aac",
 "playPathAacv224": "http://fdfs.xmcdn.com/group16/M02/15/E1/wKgDalVu857jcy3eAEC1PhLxCfk274.m4a",
 "title": "八卦江湖丨女汉子的自我修养，萌妹子的日常进化√（0604）",
 "duration": 1349.59
 */
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,copy) NSString  *playUrl64;
@property(nonatomic,copy) NSString  *downloadUrl;
@property(nonatomic,copy) NSString  *playPathAacv224;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,assign,getter=isPlaying) BOOL playing;

@end
