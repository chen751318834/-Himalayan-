//
//  RCUserlAudioOrAlbumList.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
///
@interface RCUserlAudioOrAlbumList : NSObject
/**
 *   "trackId": 4766034,
 "uid": 1653741,
 "playUrl64": "http://fdfs.xmcdn.com/group5/M0A/01/C5/wKgDtVSb183AcqglAA6OWO2AX6c770.mp3",
 "playUrl32": "http://fdfs.xmcdn.com/group5/M0A/00/BA/wKgDtlSb182TU3wOAAdHfWHnRTE520.mp3",

 "duration": 119.18,
 "categoryId": 6,
 "processState": 2,

 "nickname": "H_小布丁",
 "smallLogo": "http://fdfs.xmcdn.com/group5/M0A/01/E6/wKgDtVSb4aOR5wJRADlTCRQbnyM701_mobile_small.JPG",
 "isLike": false,
 "userSource": 1,
 "albumId": 316581,
 "albumTitle": "布丁学成语",
 "opType": 1,
 "isRelay": false,
 "commentId": "0",
 "isPublic": true,
 "likes": 0,

 "comments": 0,


 "downloadSize": 494869
 */
@property(nonatomic,copy) NSString  *playUrl32;
@property(nonatomic,copy) NSString  *playUrl64;
@property(nonatomic,copy) NSString  *smallLogo;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *coverMiddle;
@property(nonatomic,copy) NSString  *coverLarge;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *processState;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *opType;
@property(nonatomic,strong) NSNumber  *commentId;
@property(nonatomic,strong) NSNumber  *likes;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *playTimes;
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,strong) NSNumber  *downloadSize;
@end
