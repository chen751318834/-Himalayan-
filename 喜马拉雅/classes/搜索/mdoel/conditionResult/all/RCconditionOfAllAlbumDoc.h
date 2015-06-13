//
//  RCconditionOfAllAlbumDoc.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCconditionOfAllAlbumDoc : NSObject
/**
 *     "uid": 4476035,
 "mobileDistribute": 0,
 "mobileCopyright": 0,
 "last_uptrack_at_hour": -374728,
 "is_v": true,
 "id": 223331,
 "title": "青雪故事“真人秀”（短篇）",
 "last_uptrack_at": "1970-01-01T08:00:00+08:00",
 "created_at": 1385053318000,
 "is_finished": "1",
 "webCopyright": 0,
 "webDistribute": 0,
 "tags": "惊悚,青雪故事,鬼故事,恐怖,真人秀",
 "category_id": 3,
 "cover_path": "http://fdfs.xmcdn.com/group3/M03/91/A4/wKgDslKnDq6hgpNpAACzGNv0FXw051_mobile_small.jpg",
 "intro": "夜深人静的时候，请不要单独收听——《青雪故事》！【新浪官微“青雪故事2010”】【微信公众号“青雪故事”，目前有同名假号，请您搜索唯一微信号“qingxuegushi2014”。】 ",
 "user_source": "1",
 "updated_at": 1433910073000,
 "nickname": "青雪故事2010",
 "play": 6668289,
 "tracks": 155
 

 "smallPic": "http://fdfs.xmcdn.com/group1/M00/01/EE/wKgDrlCh3GmxqP6UAATNTE2HfNA284_mobile_small.jpg",
 "mobileCopyright": 0,
 "logoPic": "group1/M00/01/EE/wKgDrlCh3GmxqP6UAATNTE2HfNA284.jpg",
 "intro": "《冬吴相对论》是极具原创精神的广播脱口秀节目。节目主张是坐着为您打通经济生活任督二脉。",
 "last_update": 1429326186000,
 "personDescribe": "梁冬吴伯凡商业脱口秀",
 "gender": "保密",
 "pTtitle": "央广财经脱口秀",
 "tracks_counts": 715,
 "followers_counts": 770480,
 "followings_counts": 36
 
 
 "created_at_hour": 18159,
 "play_path_64": "http://fdfs.xmcdn.com/group4/M06/8A/F2/wKgDs1RN7u_Bj3mrAM5VPzurHc0782.mp3",
 "category_title": "最新资讯",
 "title": "473：灵长类机器",
 "play_path": "http://fdfs.xmcdn.com/group4/M06/8A/F2/wKgDs1RN7u_Bj3mrAM5VPzurHc0782.mp3",
 "created_at": 1414393588000,
 "tags": "21世纪,梁冬,吴伯凡,商业,冬吴相对论",
 "upload_id": "c_1885368",
 "category_id": 1,
 "waveform": "group4/M06/8A/F2/wKgDs1RN7uehusjLAAAKuQxP3Ek3680.js",
 "cover_path": "http://fdfs.xmcdn.com/group4/M09/17/F1/wKgDtFQWrLKBwV31AADqba3IY4g271_mobile_small.jpg",
 "user_source": 2,
 "duration": 1690.2,
 "updated_at": 1429331017000,
 "play_path_32": "http://fdfs.xmcdn.com/group4/M04/8E/59/wKgDtFRN7uqieLJWAGcrCwZr1h0670.mp3",
 "upload_source": 2,

 "album_cover_path": "http://fdfs.xmcdn.com/group4/M07/14/75/wKgDs1QWrSXTsH9YAADqba3IY4g302_mobile_small.jpg",
 "album_id": 265001,
 "mobileCopyright": 0,
 "album_title": "冬吴相对论播客",
 "webCopyright": 0,
 "uid": "1000577",
 "is_v": false,
 "nickname": "冬吴相对论",
 "count_play": 153312,
 "count_comment": 143,
 "count_share": 25,
 "count_like": 633,


 */
@property(nonatomic,copy) NSString  *play_path_32;
@property(nonatomic,copy) NSString  *album_cover_path;

@property(nonatomic,strong) NSNumber  *album_id;
@property(nonatomic,strong) NSNumber  *duration;
@property(nonatomic,strong) NSNumber  *count_play;
@property(nonatomic,strong) NSNumber  *count_comment;
@property(nonatomic,strong) NSNumber  *count_share;
@property(nonatomic,strong) NSNumber  *count_like;
@property(nonatomic,copy) NSString  *smallPic;
@property(nonatomic,copy) NSString  *logoPic;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *gender;
@property(nonatomic,copy) NSString  *personDescribe;
@property(nonatomic,copy) NSString  *pTtitle;

@property(nonatomic,strong) NSNumber  *tracks_counts;
@property(nonatomic,strong) NSNumber  *followers_counts;
@property(nonatomic,strong) NSNumber  *followings_counts;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *mobileDistribute;
@property(nonatomic,strong) NSNumber  *mobileCopyright;
@property(nonatomic,strong) NSNumber  *last_uptrack_at_hour;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *created_at;
@property(nonatomic,strong) NSNumber  *webCopyright;
@property(nonatomic,strong) NSNumber  *webDistribute;
@property(nonatomic,strong) NSNumber  *updated_at;
@property(nonatomic,strong) NSNumber  *category_id;
@property(nonatomic,strong) NSNumber  *play;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *last_uptrack_at;
@property(nonatomic,copy) NSString  *tags;
@property(nonatomic,copy) NSString  *cover_path;
@property(nonatomic,copy) NSString  *user_source;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,assign) BOOL is_v;
@property(nonatomic,copy) NSString  *createdTime;


@end
