//
//  RCOnneHotAudio.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCOnneHotAudio : NSObject
/**
 *   "id": 283384,
 "uid": 1372242,
 "title": "催眠音乐 仙境催眠曲",
 "nickname": "催眠音乐",
 "duration": 302.21,
 "playsCounts": 5006299,
 "commentsCounts": 5616,
 "sharesCounts": 2143,
 "favoritesCounts": 28533,
 "coverSmall": "http://fdfs.xmcdn.com/group2/M02/03/0E/wKgDr1Fs2tCiHNgpAAKyaWpb02k963_web_large.jpg",
 "playPath32": "http://fdfs.xmcdn.com/group2/M00/03/10/wKgDr1Fs4yvBxp5jABJyUkCxI5g868.mp3",
 "playPath64": "http://fdfs.xmcdn.com/group2/M00/03/08/wKgDsFFs4y3AVwK5ACTkXBhSyw8274.mp3",
 "userSource": 2,
 "createdAt": 1366090550000
 */
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *playPath32;
@property(nonatomic,copy) NSString  *coverSmall;
@property(nonatomic,copy) NSString  *playPath64;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *playsCounts;
@property(nonatomic,strong) NSNumber  *commentsCounts;
@property(nonatomic,strong) NSNumber  *sharesCounts;
@property(nonatomic,strong) NSNumber  *favoritesCounts;
@property(nonatomic,strong) NSNumber  *userSource;
@property(nonatomic,strong) NSNumber  *createdAt;
@end
