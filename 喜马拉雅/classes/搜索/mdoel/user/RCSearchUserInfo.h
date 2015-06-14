//
//  RCSearchUserInfo.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSearchUserInfo : NSObject
/**

 "hasPwd": false,
 "uid": 1653741,
 "ret": 0,
 "isMutualFollowed": false,
 "followings": 0,
 "location": "新疆乌鲁木齐",
 "events": 0,
 "favoriteAlbums": 0,
 "followingTags": 0,
 "messages": 0,
 "followers": 14,
 "newFeedCount": 0,
 "backgroundLogo": "http://fdfs.xmcdn.com/group5/M09/02/BA/wKgDtVScGQGz8cTlAAKkWAT8JYY204_large.jpg",
 "newEventCount": 0,
 "hasLive": false,
 "newZoneCommentCount": 0,
 "isFollowed": false,
 "mobileSmallLogo": "http://fdfs.xmcdn.com/group5/M0A/01/E6/wKgDtVSb4aOR5wJRADlTCRQbnyM701_mobile_small.JPG",
 "newThirdRegisters": 0,
 "mobileLargeLogo": "http://fdfs.xmcdn.com/group5/M0A/01/E6/wKgDtVSb4aOR5wJRADlTCRQbnyM701_mobile_x_large.JPG",
 "isVerified": true,
 "totalSpace": 0,
 "usedSpace": 0,
 "contents": 0,
 "nickname": "H_小布丁",
 "newAts": 0,
 "favorites": 0,
 "tracks": 5,
 "mobileMiddleLogo": "http://fdfs.xmcdn.com/group5/M0A/01/E6/wKgDtVSb4aOR5wJRADlTCRQbnyM701_web_x_large.JPG",
 "newComments": 0,
 "personalSignature": "现在就介绍一下自己最明显的特点，让人们记住我。",
 "personDescribe": "成语故事，少儿百科",
 "leters": 0,
 "noReadFollowers": 0,
 "ptitle": "成语故事，少儿百科",
 "albums": 1,
 "listeneds": 0,
 "favoriteAlbumIsUpdate": false

 */
@property(nonatomic,strong) NSNumber  *followings;
@property(nonatomic,strong) NSNumber  *events;
@property(nonatomic,strong) NSNumber  *favoriteAlbums;
@property(nonatomic,strong) NSNumber  *messages;
@property(nonatomic,copy) NSString  *nickname;

@property(nonatomic,strong) NSNumber  *followers;
@property(nonatomic,strong) NSNumber  *ats;
@property(nonatomic,strong) NSNumber  *evetCount;
@property(nonatomic,strong) NSNumber  *thirdRegisters;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,strong) NSNumber  *totalSpace;
@property(nonatomic,strong) NSNumber  *usedSpace;
@property(nonatomic,strong) NSNumber  *contents;
@property(nonatomic,strong) NSNumber  *favorites;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *leters;
@property(nonatomic,strong) NSNumber  *noReadFollowers;
@property(nonatomic,strong) NSNumber  *albums;
@property(nonatomic,strong) NSNumber  *listeneds;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,copy) NSString  *location;
@property(nonatomic,copy) NSString  *backgroundLogo;
@property(nonatomic,copy) NSString  *mobileSmallLogo;
@property(nonatomic,copy) NSString  *mobileLargeLogo;

@property(nonatomic,copy) NSString  *personalSignature;
@property(nonatomic,copy) NSString  *personDescribe;
@property(nonatomic,copy) NSString  *ptitle;

@end
