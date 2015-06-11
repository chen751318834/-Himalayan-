//
//  RCAlbum.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAlbum : NSObject
/**
 *  "id": 321705,
 "title": "今晚80后脱口秀 2015",
 "albumCoverUrl290": "http://fdfs.xmcdn.com/group12/M00/09/7A/wKgDW1VfCQjwLbK8AAGaZRNRrII383_mobile_large.jpg",
 "lastUptrackAt": 1432447947000,
 "playsCounts": 13012836,
 "tracksCounts": 29,
 "serialState": 0
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *lastUptrackAt;
@property(nonatomic,copy) NSString  *lastUptrackTime;

@property(nonatomic,strong) NSNumber  *playsCounts;
@property(nonatomic,strong) NSNumber  *tracksCounts;
@property(nonatomic,strong) NSNumber  *serialState;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *albumCoverUrl290;
@property(nonatomic,copy) NSString  *coverSmall;

@property(nonatomic,assign,getter=isCollect) BOOL collect;

@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *updatedAt;
@property(nonatomic,copy) NSString  *updateTime;

@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,strong) NSNumber  *createdAt;
@property(nonatomic,copy) NSString  *createTime;

@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *zoneId;
@property(nonatomic,strong) NSNumber  *shares;
@property(nonatomic,strong) NSNumber  *playTimes;
@property(nonatomic,copy) NSString  *categoryName;
@property(nonatomic,copy) NSString  *coverLarge;
@property(nonatomic,copy) NSString  *coverWebLarge;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *avatarPath;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *introRich;
@property(nonatomic,copy) NSString  *tags;
@property(nonatomic,copy) NSString  *coverOrigin;

@property(nonatomic,assign) BOOL isVerified;
@property(nonatomic,assign) BOOL hasNew;
@property(nonatomic,assign) BOOL isFavorite;
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,assign,getter=isCollected) BOOL collected;
@property(nonatomic,copy) NSString  *playUrl32;
@property(nonatomic,copy) NSString  *playUrl64;
@property(nonatomic,copy) NSString  *smallLogo;
@property(nonatomic,copy) NSString  *coverMiddle;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *processState;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *opType;
@property(nonatomic,strong) NSNumber  *commentId;
@property(nonatomic,strong) NSNumber  *likes;
@property(nonatomic,strong) NSNumber  *comments;
@property(nonatomic,strong) NSNumber  *downloadSize;
@end
