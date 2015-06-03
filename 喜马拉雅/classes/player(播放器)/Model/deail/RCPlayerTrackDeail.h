//
//  RCPlayerTrackDeail.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCplayerUserInfo.h"
@interface RCPlayerTrackDeail : NSObject
/**
 *    "uid": 1000202,
 "downloadSize": 6531854,
 "downloadUrl": "http://fdfs.xmcdn.com/group14/M0B/13/87/wKgDY1VrvP-x4ddyAGOrDtQnn0Y653.aac",
 "albumTitle": "郭德纲相声十年经典之七",
 "playUrl32": "http://fdfs.xmcdn.com/group9/M01/13/58/wKgDYlVrvOTSl6IkAGAM23bcS2M310.mp3",
 "activityId": 0,
 "categoryName": "相声评书",
 "richIntro": "郭德纲相声十年经典之七",
 "processState": 2,
 "coverSmall": "http://fdfs.xmcdn.com/group13/M07/14/A9/wKgDXVVthZ2CrP9rAAOtEHJ07h0288_mobile_small.jpg",
 "playUrl64": "http://fdfs.xmcdn.com/group12/M02/13/3E/wKgDXFVrvVPSPi_aAMAZbQXh6O4770.mp3",
 "albumId": 389197,
 "status": 1,
 "categoryId": 12,
 "shares": 12,
 "isLike": false,
 "likes": 230,
 "images": [],
 "isRelay": false,
 "userSource": 1,
 "playtimes": 34633,
 "coverLarge": "http://fdfs.xmcdn.com/group13/M07/14/A9/wKgDXVVthZ2CrP9rAAOtEHJ07h0288_mobile_large.jpg",
 "title": "2008高清《批三国》（郭德纲 于谦）",
 "createdAt": 1433241006000,
 "downloadAacSize": 4858060,
 "albumImage": "http://fdfs.xmcdn.com/group6/M04/4C/30/wKgDg1U0uZ-BJE6gAAOtEHJ07h0038_mobile_small.jpg",
 "userInfo": {},
 "trackBlocks": [ ],
 "tags": "郭德纲,相声大全,德云社,郭德纲相声",
 "trackId": 7134464,
 "isPublic": true,
 "intro": "郭德纲相声十年经典之七",
 "duration": 1573,
 "downloadAacUrl": "http://fdfs.xmcdn.com/group14/M0B/13/73/wKgDZFVrvPTyL0cMAEogzBlHnYc721.m4a",
 "playPathAacv164": "http://fdfs.xmcdn.com/group9/M01/13/58/wKgDYlVrvOawRIGhAMIyYUee0Bc788.m4a",
 "comments": 55
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *downloadSize;
@property(nonatomic,strong) NSNumber  *activityId;
@property(nonatomic,strong) NSNumber  *processState;
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,strong) NSNumber  *likes;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *playtimes;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *downloadAacSize;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,copy) NSString  *downloadUrl;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,copy) NSString  *playUrl32;
@property(nonatomic,copy) NSString  *categoryName;
@property(nonatomic,copy) NSString  *richIntro;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *playUrl64;
@property(nonatomic,copy) NSString  *coverLarge;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *albumImage;
@property(nonatomic,copy) NSString  *tagstags;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *downloadAacUrl;
@property(nonatomic,copy) NSString  *playPathAacv164;
@property(nonatomic,copy) NSString  *tags;

@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,assign) BOOL isRelay;
@property(nonatomic,assign) BOOL isPublic;
@property(nonatomic,strong) RCplayerUserInfo  *userInfo;
@property(nonatomic,strong) NSArray  *images;
@property(nonatomic,strong) NSArray  *trackBlocks;

@end
