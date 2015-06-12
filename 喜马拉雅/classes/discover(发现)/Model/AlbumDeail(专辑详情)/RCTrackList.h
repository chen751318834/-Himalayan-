//
//  RCTrackList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RCTrackList : NSObject
/**
 *   "trackId": 6953023,
 "uid": 9216785,
 "playUrl32": "http://fdfs.xmcdn.com/group10/M07/09/6B/wKgDZ1Ve_y2w5Sj0ABGnXCyppG8480.mp3",
 "downloadUrl": "http://fdfs.xmcdn.com/group11/M04/09/A1/wKgDa1Ve_y_yF8w0ABJRew5t6-Y774.aac",
 "title": "第265夜：小猪学跳绳-飞飞姐姐",
 "duration": 289.2,
 "processState": 2,
 "createdAt": 1432548240000,
 "coverSmall": "http://fdfs.xmcdn.com/group12/M09/09/74/wKgDW1Ve_3ez98eAAACsBm88lgQ344_mobile_small.jpg",
 "nickname": "一千零一夜电台",
 "smallLogo": "http://fdfs.xmcdn.com/group5/M01/19/22/wKgDtVN9tWSDl0C3AAPIbmv9JFU437_mobile_small.jpg",
 "userSource": 1,
 "albumId": 257813,
 "albumTitle": "【一千零一夜】睡前故事",
 "albumImage": "http://fdfs.xmcdn.com/group5/M01/63/36/wKgDtVOygRLTfiE4AATGSSgr1kA848_mobile_small.jpg",
 "orderNum": 99999999,
 "opType": 1,
 "isPublic": true,
 "likes": 19,
 "playtimes": 1224,
 "comments": 4,
 "shares": 0,
 "status": 1,
 "downloadSize": 1200507
 */
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *processState;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *orderNum;
@property(nonatomic,strong) NSNumber  *opType;
@property(nonatomic,strong) NSNumber  *likes;
@property(nonatomic,strong) NSNumber  *playtimes;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,copy) NSString  *playUrl32;
@property(nonatomic,copy) NSString  *downloadUrl;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,copy) NSString  *albumImage;
@property(nonatomic,strong) NSNumber  *downloadSize;
@property(nonatomic,assign) BOOL isPublic;
@property(nonatomic,copy) NSString  *created_at;
@property(nonatomic,assign,getter=isDownloaded) BOOL downloaded;
@property(nonatomic,assign,getter=isCheck) BOOL check;
@property(nonatomic,copy) NSString  *playPath32;
@property(nonatomic,copy) NSString  *playPath64;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *playsCounts;

@property(nonatomic,strong) NSNumber  *commentsCounts;
@property(nonatomic,strong) NSNumber  *sharesCounts;
@property(nonatomic,strong) NSNumber  *favoritesCounts;
@property(nonatomic,assign) NSUInteger  audioCount;
@property(nonatomic,assign) CGFloat percentDone;
@property(nonatomic,assign) long long totalBytesReadForFile;
@property(nonatomic,assign) long long totalBytesExpectedToReadForFile;
@property(nonatomic,copy) NSString  *playUrl64;

@property(nonatomic,copy) NSString  *coverMiddle;
@property(nonatomic,copy) NSString  *coverLarge;

@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *commentId;

@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,copy) NSString  *updatedTime;

@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *playTimes;

@end
