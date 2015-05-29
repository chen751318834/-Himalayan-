//
//  RCAttentionOneData.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAttentionOneData : NSObject
/**
 *  "lastUpdateAt": 1431903179000,
 "unreadNum": 10,
 "timeline": 14319031790000.46,
 "dynamicType": 2
 "albumId": 215052,
 "albumCover": "http://fdfs.xmcdn.com/group4/M00/E9/D4/wKgDtFQBaTKACDQCAAHprtEndtg125_mobile_meduim.png",
 "albumTitle": "敏捷项目管理"
  lastUpdateAt,
 "lastUpdateAt": 1409138100000,
 "uid": 3743751,
 "nickname": "钱安川",
 "avatar": "http://tp3.sinaimg.cn/1528565530/180/5658111436/1",
 "trackId": 3508976,
 "trackTitle": "创业团队的极简管理",
 "trackType": 1,
 "playPath64": "http://fdfs.xmcdn.com/group4/M04/DC/92/wKgDs1P9vVDTOHGhAYANbD83fSM859.mp3",
 "unreadNum": 0,
 "isTop": false,
 "dynamicType": 1
 */
@property(nonatomic,strong) NSNumber  *lastUpdateAt;
@property(nonatomic,copy) NSString  *updateTime;

@property(nonatomic,strong) NSNumber  *unreadNum;
@property(nonatomic,strong) NSNumber  *timeline;
@property(nonatomic,strong) NSNumber  *dynamicType;
@property(nonatomic,strong) NSNumber  *albumId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *trackType;
@property(nonatomic,assign) BOOL isTop;
@property(nonatomic,copy) NSString  *albumCover;
@property(nonatomic,copy) NSString  *albumTitle;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *avatar;
@property(nonatomic,copy) NSString  *trackTitle;
@property(nonatomic,copy) NSString  *playPath64;


@end
