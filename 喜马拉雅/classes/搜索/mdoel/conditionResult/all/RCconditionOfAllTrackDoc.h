//
//  RCconditionOfAllDoc.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCconditionOfAllTrackDoc : NSObject
/**
 "uid": "4476035",
 "created_at_hour": 10798,
 "play_path_64": "http://fdfs.xmcdn.com/group3/M00/A3/D7/wKgDslK5m2PhrTJ8ACxBHCNaA4A182.mp3",
 "album_cover_path": "http://fdfs.xmcdn.com/group3/M03/91/A4/wKgDslKnDq6hgpNpAACzGNv0FXw051_mobile_small.jpg",
 "album_title": "青雪故事“真人秀”（短篇）",
 "upload_id": "u_1944334",
 "category_id": 3,
 "waveform": "group3/M01/A3/D7/wKgDslK5m2WgY6BlAAAJd705viw0756.js",
 "cover_path": "http://fdfs.xmcdn.com/group3/M01/A3/D8/wKgDslK5nIjybHzrAAE5m9n48Es688_mobile_small.jpg",
 "user_source": 1,
 "updated_at": 1434016415000,
 "play_path_32": "http://fdfs.xmcdn.com/group3/M00/A3/D7/wKgDslK5m1-h_CbTABYgn8vEUT0437.mp3",
 "mobileCopyright": 0,
 "id": "1623619",
 "play_path": "http://fdfs.xmcdn.com/group3/M01/A4/31/wKgDsVK5m1bgOJcFAE1u2_gJE3I010.mp3",
 "title": "回魂（青雪故事）",
 "created_at": 1387895953000,
 "tags": "青雪故事,真人秀,鬼故事,惊悚,恐怖",
 "album_id": 223331,
 "duration": 362.47,
 "upload_source": 2,
 "nickname": "青雪故事2010",
 "count_play": 24269,
 "count_comment": 11,
 "count_share": 2,
 "count_like": 57,

 */
@property(nonatomic,strong) NSNumber  *created_at_hour;
@property(nonatomic,strong) NSNumber  *category_id;
@property(nonatomic,strong) NSNumber  *user_source;
@property(nonatomic,strong) NSNumber  *updated_at;
@property(nonatomic,strong) NSNumber  *mobileCopyright;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *created_at;
@property(nonatomic,strong) NSNumber  *album_id;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *upload_source;
@property(nonatomic,strong) NSNumber  *count_play;
@property(nonatomic,strong) NSNumber  *count_comment;
@property(nonatomic,strong) NSNumber  *count_share;
@property(nonatomic,strong) NSNumber  *count_like;
@property(nonatomic,copy) NSString  *uid;
@property(nonatomic,copy) NSString  *play_path_64;
@property(nonatomic,copy) NSString  *album_cover_path;
@property(nonatomic,copy) NSString  *album_title;
@property(nonatomic,copy) NSString  *upload_id;
@property(nonatomic,copy) NSString  *waveform;
@property(nonatomic,copy) NSString  *cover_path;
@property(nonatomic,copy) NSString  *play_path_32;
@property(nonatomic,copy) NSString  *play_path;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *tags;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *createdTime;

@end
