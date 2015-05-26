//
//  RCOneAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCOneAlbum : NSObject

/**
*   "albumId": 257813,
"categoryId": 6,
"categoryName": "儿童",
"title": "【一千零一夜】睡前故事",
"coverOrigin": "http://fdfs.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848.jpg",
"coverSmall": "http://fdfs.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848_mobile_small.jpg",
"coverLarge": "http://fdfs.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848_mobile_meduim.jpg",
"coverWebLarge": "http://fdfs.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848_web_large.jpg",
"createdAt": 1401270599000,
"updatedAt": 1432548240000,
"uid": 9216785,
"nickname": "一千零一夜电台",
"isVerified": true,
"avatarPath": "http://fdfs.xmcdn.com/group5/M01/19/22/wKgDtVN9tWSDl0C3AAPIbmv9JFU437_mobile_small.jpg",
"zoneId": 32,
"intro": "【一千零一夜】睡前故事",
"introRich": "【一千零一夜】睡前故事",
"tags": "儿童故事,童话,睡觉故事,儿童教育,睡前故事",
"tracks": 267,
"shares": 0,
"hasNew": false,
"isFavorite": false,
"playTimes": 61727871,
"lastUptrackAt": 1432548240000,
"status": 1
 
 http://mobile.ximalaya.com/m/tags/get_albums?sort=hot&device=android&tname=儿童&page=1
*/
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *zoneId;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *playTimes;
@property(nonatomic,strong) NSNumber  *lastUptrackAt;
@property(nonatomic,copy) NSString  *categoryName;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverOrigin;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *coverLarge;
@property(nonatomic,copy) NSString  *coverWebLarge;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *avatarPath;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *introRich;
@property(nonatomic,copy) NSString  *tags;
@property(nonatomic,assign) BOOL isVerified;
@property(nonatomic,assign) BOOL hasNew;
@property(nonatomic,assign) BOOL isFavorite;
@property(nonatomic,strong) NSNumber  *status;

@end
