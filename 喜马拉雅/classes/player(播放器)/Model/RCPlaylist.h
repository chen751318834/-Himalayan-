//
//  RCPlaylist.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCplayerUserInfo.h"
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
@property(nonatomic,assign,getter=isDownloaded) BOOL downloaded;
@property(nonatomic,copy) NSString  *coverLarge;
@property(nonatomic,strong) NSNumber  *albumId;
/**
 *     "uid": 1412917,
 "downloadSize": 12946933,
 "downloadUrl": "http://fdfs.xmcdn.com/group13/M04/11/1E/wKgDXlVnmUbwVNSrAMWN9WuYU2E208.aac",
 "albumTitle": "罗辑思维 全集",
 "playUrl32": "http://fdfs.xmcdn.com/group14/M04/10/F6/wKgDY1VnmTrBZXx0AMWJZ0Mx_4o230.mp3",
 "activityId": 0,
 "categoryName": "综艺娱乐",
 "richIntro": "",
 "processState": 2,
 "coverSmall": "http://fdfs.xmcdn.com/group9/M04/12/09/wKgDZlVpMFCQEpTeAAHjHCQ8i2g009_mobile_small.jpg",
 "playUrl64": "http://fdfs.xmcdn.com/group14/M04/10/E3/wKgDZFVnmUSj6sfJAYsR-WniO6w203.mp3",
 "albumId": 239463,
 "status": 1,
 "categoryId": 4,
 "msg": "0",
 "shares": 49,
 "isLike": false,
 "likes": 1914,
 "images": [],
 "isRelay": false,
 "ret": 0,
 "userSource": 2,
 "playtimes": 281282,
 "coverLarge": "http://fdfs.xmcdn.com/group9/M04/12/09/wKgDZlVpMFCQEpTeAAHjHCQ8i2g009_mobile_large.jpg",
 "title": "午夜将至[罗辑思维]No.123",
 "createdAt": 1432942987000,
 "albumImage": "http://fdfs.xmcdn.com/group5/M09/4A/32/wKgDtlS4cZeCzmE2AAHjHCQ8i2g083_mobile_small.jpg",
 "userInfo": {},
 "trackBlocks": [ ],
 "tags": "罗辑思维,罗振宇,脱口秀",
 "trackId": 7075184,
 "isPublic": true,
 "intro": "",
 "duration": 3236,
 "lyric": "",
 "playPathAacv164": "",
 "playPathAacv224": "",
 "comments": 326
 */
@property(nonatomic,strong) RCplayerUserInfo  *userInfo;
@property(nonatomic,strong) NSNumber  *downloadSize;
@property(nonatomic,strong) NSNumber  *activityId;
@property(nonatomic,strong) NSNumber  *processState;
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *likes;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *playtimes;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,copy) NSString  *playUrl32;
@property(nonatomic,copy) NSString  *categoryName;
@property(nonatomic,copy) NSString  *richIntro;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *albumImage;
@property(nonatomic,copy) NSString  *tags;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *lyric;
@property(nonatomic,copy) NSString  *playPathAacv164;
@property(nonatomic,assign) BOOL isRelay;
@property(nonatomic,assign) BOOL isPublic;
@property(nonatomic,strong) NSArray  *images;
@property(nonatomic,strong) NSArray  *trackBlocks;
@property(nonatomic,copy) NSString  *playTime;
@end
